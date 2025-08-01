exports.handler = async (event) => {
  // This may help you get an idea of what the event looks like.
  // Event contents differ depending on the service that executes it.
  console.log("Event received:", JSON.stringify(event, null, 2));

  // this response is generally compatible with integrations that work like a web api
  // function urls,  api gateway, load balencers, etc
  const response = {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      message: "Hello World from Lambda!",
      timestamp: new Date().toISOString(),
      event: event,
    }),
  };

  return response;
};
