import React, {useState} from "react";
import Faker from 'faker';
import Cookies from "js-cookie";
import {UserContext, ParentTweetContext} from "../util/context";

const StateProvider = ({initialUsername, initialAvatar, children}) => {
	const usernameCache = Cookies.get("username");
	const avatarCache = Cookies.get("avatar");

	const [username, setUsername] = useState(initialUsername || usernameCache || Faker.internet.userName());
	const [avatar, setAvatar] = useState(initialUsername || avatarCache || Faker.internet.avatar());
	const [parentTweet, setParentTweet] = useState();

	if (username !== usernameCache) {
		Cookies.set("username", username)
	}
	if (avatar !== avatarCache) {
		Cookies.set("avatar", avatar)
	}

	const changeUser = () => { // get and update new username, avatar
		const newUsername = Faker.internet.userName();
		setUsername(newUsername);
		Cookies.set("username", newUsername);

		const newAvatar = Faker.internet.avatar();
		setAvatar(newAvatar);
		Cookies.set("avatar", newAvatar)
	};

	return (
		<UserContext.Provider value={{username, avatar, changeUser}}>
			<ParentTweetContext.Provider value={{parentTweet, setParentTweet}}>
				{children}
			</ParentTweetContext.Provider>
		</UserContext.Provider>
	);
};

export default StateProvider;
