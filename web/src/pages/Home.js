import React from 'react';
import {Box, LatestTweetPanel, TopTweetPanel} from "../components";
import "./Home.css"

function Home() {
	return (
		<div className="container-fluid gedf-wrapper">
			<div className="row">
				<div className="col-md-6 gedf-main">
					<Box/>
					<LatestTweetPanel name={"Latest"}/>
				</div>
				<div className="col-md-6 gedf-main">
					<TopTweetPanel name={"Top most re-tweeted"} longPanel/>
				</div>
			</div>
		</div>
	);
}

export default Home;
