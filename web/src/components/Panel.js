import React, { useRef, useLayoutEffect } from 'react';
import {Tweet} from "./Tweet";
import {withLatestTweet, withTopTweets} from "../hocs";
import "./Panel.css";

export const Panel = ({name, longPanel, tweets = []}) => {
	const ref = useRef();

	useLayoutEffect(() => {
		// scroll on top list if tweets updated
		ref.current.scrollTop = 0;

		// scroll on bottom list if tweets updated
		// ref.current.scrollTop = ref.current.scrollHeight;
	}, [tweets]);

	return (
		<div className="card gedf-card">
			<div className="card-header">
				<ul className="nav nav-tabs card-header-tabs" id="myTab" role="tablist">
					<li className="nav-item">
						<a className="nav-link active">{name}</a>
					</li>
				</ul>
			</div>
			<div ref={ref} className={longPanel ? "scroll-tab long-tab" : "scroll-tab"}>
				{tweets.map((tweet) => (<Tweet key={tweet.id} {...tweet}/>))}
			</div>
		</div>
	);
};

export const LatestTweetPanel = withLatestTweet(Panel);

export const TopTweetPanel = withTopTweets(Panel);
