import React, {useState, useEffect} from "react";
import gql from "graphql-tag";
import { useSubscription } from "@apollo/react-hooks";
import {TweetFragment} from "../graphql";

const CREATED_TWEET_SUBSCRIPTION = gql`
    subscription {
        tweetCreated {
            ...TweetFragment
        }
    }
    ${TweetFragment}
`;

const withLatestTweet = ChildComp => (props) => {
	const [tweets, setTweets] = useState([]);

	const { data } = useSubscription(CREATED_TWEET_SUBSCRIPTION);

	useEffect(() => {
		if(data && data.tweetCreated){
			setTweets([data.tweetCreated, ...tweets])
		}
	}, [data]);

	return <ChildComp {...props} {...{tweets}} />
};

export default withLatestTweet;
