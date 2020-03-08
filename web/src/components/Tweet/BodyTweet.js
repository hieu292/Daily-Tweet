import React from "react";
import ParentTweet from "./ParentTweet";

const BodyTweet = ({body, parent}) => {
	return (
		<div className="card-body">
			{!!parent && <ParentTweet {...parent}/>}
			<p className="card-text">{body}</p>
		</div>
	)
};

export default BodyTweet;
