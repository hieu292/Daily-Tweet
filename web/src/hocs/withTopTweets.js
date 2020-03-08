import React, {useCallback} from "react";
import gql from "graphql-tag";
import {useQuery} from "@apollo/react-hooks";
import {TweetFragment} from "../graphql";
import {Subscriber} from "../containers";
import {QueryResult} from "../components";

const GET_TOP_RETWEET = gql`
    query {
        topTweets {
            ...TweetFragment
        }
    }
    ${TweetFragment}
`;

const TOP_RETWEET_SUBSCRIPTION = gql`
    subscription {
        topTweets {
            ...TweetFragment
        }
    }
    ${TweetFragment}
`;

const withTopTweets = ChildComp => (props) => {
	const {subscribeToMore, ...queryResult} = useQuery(GET_TOP_RETWEET);

	const subscribeToNew = useCallback(() =>
		subscribeToMore({
			document: TOP_RETWEET_SUBSCRIPTION,
			updateQuery: (prev, {subscriptionData}) => {
				if (!subscriptionData.data) return prev;
				return subscriptionData.data;
			},
		}),
	);

	return (
		<QueryResult {...queryResult}>
			{({data: {topTweets: tweets}}) =>
					(<Subscriber subscribeToNew={subscribeToNew}>
						<ChildComp {...props} {...{tweets}} />
					</Subscriber>)
			}
		</QueryResult>
	)
};

export default withTopTweets;
