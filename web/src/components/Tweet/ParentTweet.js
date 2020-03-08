import React from "react";
import HeaderTweet from "./HeaderTweet";
import BodyTweet from "./BodyTweet";

const ParentTweet = ({name, insertedAt, avatar, retweetCount, body}) => {
	return (
		<div className="card gedf-card">
			<HeaderTweet {...{name, avatar, insertedAt, retweetCount}}/>
			<BodyTweet {...{body}}/>
		</div>
	)
};

export default ParentTweet;
