import React from 'react';
import HeaderTweet from "./HeaderTweet";
import BodyTweet from "./BodyTweet";
import FooterTweet from "./FooterTweet";

const Tweet = (tweet) => {
	const {name, insertedAt, avatar, retweetCount, body, parent} = tweet;
	return (
		<div className="card gedf-card">
			<HeaderTweet {...{name, avatar, insertedAt, retweetCount}}/>
			<BodyTweet {...{body, parent}}/>
			<FooterTweet {...{tweet}}/>
		</div>
	)
};

export default Tweet;
