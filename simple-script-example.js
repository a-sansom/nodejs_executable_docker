let i = 1;
// Get the param passed in, either via the default Dockerfile CMD value, or
// the override of that value specified via the CLI when the container is
// run.
let iterate_to = process.argv[2];

console.log('Number of iterations: ' + iterate_to);

setInterval(() => {
    // We're checking equality, not strict eqauality as we (in this basic
    // example) are getting the input param as a string.
    if (i > iterate_to) {
        console.log('Completed required number of iterations, exiting...');
        process.exit(0);
    }

    console.log('Iteration: ' + i);
    i++;
}, 1000);