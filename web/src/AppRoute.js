import React from "react";
import { Switch, Route } from "react-router-dom";
import { ToastContainer } from 'react-toastify';
import {Nav, ReTweetModal} from "./components";
import { StateProvider } from "./containers";
import { Home } from "./pages";

const App = (props) => {
	return (
		<StateProvider {...props}>
			<Nav />
			<Switch>
				<Route component={Home} />
			</Switch>
			<ToastContainer/>
			<ReTweetModal />
		</StateProvider>
	);
};

export default App;
