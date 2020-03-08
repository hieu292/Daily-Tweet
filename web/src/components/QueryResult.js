import React from "react";
import Loading from "./Loading";
import ErrorMessage from "./ErrorMessage";

const QueryResult = ({ loading, error, data, children }) => {
  if (loading) {
    return <Loading />;
  } else if (error) {
    return <ErrorMessage message={error.message} />;
  } else {
    return children({ data });
  }
};

export default QueryResult;
