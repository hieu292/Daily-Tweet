import React, {useContext} from "react";
import {UserContext} from "../util/context";

const AppNav = () => {
	const {username, avatar, changeUser} = useContext(UserContext);

	return (
		<nav className="navbar navbar-dark bg-dark">
			<a href="#" className="navbar-brand">Daily Tweet</a>
			<a href="#" onClick={changeUser}>
				<span className="navbar-brand">{username}</span>
				<img className="rounded-circle" width="45" src={avatar} alt="avatar"/>
			</a>
		</nav>
	)
};

export default AppNav;
