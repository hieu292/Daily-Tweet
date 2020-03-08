import React, {useState, useEffect, useContext} from 'react';
import {withCreateTweet} from "../hocs";
import {ParentTweetContext} from "../util/context";

const Box = ({createTweet, loading}) => {
	const [body, setBody] = useState("");
	const [isValidBody, setValidBody] = useState(false);
	const { setParentTweet } = useContext(ParentTweetContext);

	useEffect(() => {
		if(body.length > 0 && body.length <= 140 && !loading){
			setValidBody(true)
		} else {
			setValidBody(false)
		}
	}, [body, loading]);

	const handleCreateTweet = () => {
		createTweet(body);
		setParentTweet(null);
		setBody("")
	};

	return (
		<div className="card gedf-card">
			<div className="card-body">
				<div className="tab-content" id="myTabContent">
					<div className="tab-pane fade show active" id="posts" role="tabpanel"
					     aria-labelledby="posts-tab">
						<div className="form-group">
							<label className="sr-only" htmlFor="message">post</label>
							<textarea
								className="form-control"
								id="message" rows="3"
								value={body}
								onChange={e => setBody(e.target.value)}
								placeholder="What are you thinking?"
							/>
						</div>
					</div>
				</div>
				<div className="btn-toolbar justify-content-end">
					<div className="btn-group">
						<button type="submit"
						        className="btn btn-primary"
						        disabled={!isValidBody}
						        onClick={handleCreateTweet}>
							{loading ? "Tweeting..." : "Tweet"}
						</button>
					</div>
				</div>
			</div>
		</div>
	);
};


export default withCreateTweet(Box);
