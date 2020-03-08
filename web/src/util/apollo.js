import ApolloClient from "apollo-client";
import {InMemoryCache} from "apollo-cache-inmemory";
import * as AbsintheSocket from "@absinthe/socket";
import {createAbsintheSocketLink} from "@absinthe/socket-apollo-link";
import {Socket as PhoenixSocket} from "phoenix";
import {createHttpLink} from "apollo-link-http";
import {hasSubscription} from "@jumpn/utils-graphql";
import {split} from "apollo-link";

const HTTP_URI =
	process.env.NODE_ENV === "production"
		? `https://${process.env.REACT_APP_API}/api/graphql`
		: "http://localhost:4000/api/graphql";

const WS_URI =
	process.env.NODE_ENV === "production"
		? `wss://${process.env.REACT_APP_API}/socket`
		: "ws://localhost:4000/socket";

function createPhoenixSocket() {
	const socket = new PhoenixSocket(WS_URI);
	socket.onError(() => {
		console.error("Error connecting WebSocket");
	});
	return socket;
}

export const createClient = ({req, fetch} = {}) => {
	let link = createHttpLink({uri: HTTP_URI, fetch});

	const absintheSocket = AbsintheSocket.create(createPhoenixSocket());
	const socketLink = createAbsintheSocketLink(absintheSocket);

	link = split(
		(operation) => hasSubscription(operation.query),
		socketLink,
		link,
	);

	const cache = new InMemoryCache();

	cache.restore(window.__APOLLO_STATE__);

	const client = new ApolloClient({
		link,
		cache,
	});
	return {client, absintheSocket};
};
