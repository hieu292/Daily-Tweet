import React, {useState, useContext, useEffect} from "react";
import {Button, Modal} from "react-bootstrap";
import {ParentTweetContext} from "../util/context";
import {ParentTweet} from "./Tweet";
import Box from "./Box";

const ReTweetModal = () => {
	const [show, setShow] = useState(false);
	const { parentTweet, setParentTweet } = useContext(ParentTweetContext);

	const handleClose = () => setShow(false);
	const handleCloseAndClear = () => {
		setParentTweet(null);
		setShow(false);
	};
	const handleShow = () => setShow(true);

	useEffect(() => {
		if(parentTweet){
			handleShow()
		} else {
			handleClose()
		}
	}, [parentTweet]);

	return (
		<Modal show={show} onHide={handleCloseAndClear}>
			<Modal.Header closeButton>
				<Modal.Title>Re-tweet</Modal.Title>
			</Modal.Header>
			<Modal.Body>
				<ParentTweet {...parentTweet}/>
			</Modal.Body>
			<div>
				<Box/>
			</div>
		</Modal>
	)
};

export default ReTweetModal;
