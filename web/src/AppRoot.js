import React, { useRef } from "react";
import { ApolloProvider } from "@apollo/react-hooks";
import { BrowserRouter } from "react-router-dom";
import { createClient } from "./util/apollo";
import AppRoute from "./AppRoute";

const AppRoot = () => {
	const client = useRef(createClient());

	return (
		<ApolloProvider client={client.current.client}>
			<BrowserRouter>
				<AppRoute socket={client.current.absintheSocket} />
			</BrowserRouter>
		</ApolloProvider>
	);
};

export default AppRoot;
