import React, {useContext} from "react";
import {ParentTweetContext} from "../../util/context";

const FooterTweet = ({tweet}) => {
	const {setParentTweet} = useContext(ParentTweetContext);
	return (
		<div className="card-footer">
			<a href="#" className="card-link" onClick={() => setParentTweet(tweet)}><i className="fa fa-gittip"></i> Re-tweet</a>
		</div>
	)
};

export default FooterTweet;
