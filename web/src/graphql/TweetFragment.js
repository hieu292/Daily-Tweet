import gql from 'graphql-tag';
import ParentTweetFragment from "./ParentTweetFragment";

export const TweetFragment = gql`
    fragment TweetFragment on Tweet  {
        id
        name
        avatar
        body
        retweetCount
        updatedAt
        insertedAt
	    parentId
	    parent {
		    ...ParentTweetFragment
	    }
    }
	${ParentTweetFragment}
`;

export default TweetFragment;
