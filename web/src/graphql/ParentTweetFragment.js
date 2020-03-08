import gql from 'graphql-tag';

export const ParentTweetFragment = gql`
    fragment ParentTweetFragment on ParentTweet  {
        id
	    name
	    avatar
        body
        retweetCount
        updatedAt
        insertedAt
    }
`;

export default ParentTweetFragment;
