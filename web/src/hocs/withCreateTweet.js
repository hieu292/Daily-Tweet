import React, { useContext } from "react";
import { useMutation } from "@apollo/react-hooks";
import { toast } from 'react-toastify';
import gql from "graphql-tag";
import {ParentTweetContext, UserContext} from "../util/context";
import {TweetFragment} from "../graphql";

export const CREATE_TWEET = gql`
    mutation ($body: String!, $name: String!, $avatar: String!, $parentId: ID){
        createTweet(body: $body, name: $name, avatar: $avatar, parentId: $parentId){
            ...TweetFragment
        }
    }
	${TweetFragment}
`;

const withCreateTweet = ChildComp => (props) => {
	const [create, {loading }] = useMutation(CREATE_TWEET);


	const { username: name, avatar } = useContext(UserContext);
	const { parentTweet } = useContext(ParentTweetContext);

	const createTweet = (body) => {
		let variables = {body, name, avatar};
		if(parentTweet){
			variables.parentId = parentTweet.id;
		}

		create({variables})
			.then(() => toast.success("New tweet created successfully!"))
			.catch((e) => toast.error(e.message));
	};

	return <ChildComp {...props} {...{createTweet, loading}}/>
};

export default withCreateTweet;
