import { app, port } from "./app.js";

// Have app listen on given port
app.listen(port, function() {
	console.log(`Server listening on port ${port}`)
});
