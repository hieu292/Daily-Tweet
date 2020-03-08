import React, {useState, useEffect} from 'react';
import moment from "moment";
import "./HeaderTweet.css"

const getTimeFromNow = utcTime => moment.utc(utcTime).fromNow();

const HeaderTweet = ({name, avatar, insertedAt, retweetCount}) => {
	const [timeFromNow, setTimeFromNow] = useState(getTimeFromNow(insertedAt));

	useEffect(() => {
		const interval = setInterval(() => {
			setTimeFromNow(getTimeFromNow(insertedAt))
		}, 1000);
		return () => clearInterval(interval);
	}, []);

	return (
		<div className="card-header">
			<div className="d-flex justify-content-between align-items-center">
				<div className="d-flex justify-content-between align-items-center">
					<div className="mr-2">
						<img className="rounded-circle" width="45"
						     src={avatar}
						     alt="avatar"/>
					</div>
					<div className="ml-2">
						<div className="h5 m-0">{name}</div>
						<div className="h7 text-muted">{timeFromNow}</div>
					</div>
				</div>
				<div>
					<span>{retweetCount} re-tweeted</span>
				</div>
			</div>
		</div>
	)
};

export default HeaderTweet;
