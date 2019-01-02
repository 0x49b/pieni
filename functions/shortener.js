/**
 * Functions used by the URL Shortener
 */


/**
 * Checks if the generated Key is already used
 * @param url
 * @param key
 */
function checkExistingKey(key) {
    client.exists(key, function (err, reply) {
        if (reply === 1) {
            return true;
        }
    });
    return false
}

/**
 * Generates a new Key or if it is set by the User returns the chosen
 * @param key
 */
function generateKey(key) {
    if (key === "") {
        key = Math.random().toString(36).substr(2, 5);
    }
    return key;
}

function printHead(){
    console.log();
    console.log();
    console.log('      ::::::::: ::::::::::: :::::::::: ::::    ::: ::::::::::: ');
    console.log('     :+:    :+:    :+:     :+:        :+:+:   :+:     :+:      ');
    console.log('    +:+    +:+    +:+     +:+        :+:+:+  +:+     +:+       ');
    console.log('   +#++:++#+     +#+     +#++:++#   +#+ +:+ +#+     +#+        ');
    console.log('  +#+           +#+     +#+        +#+  +#+#+#     +#+         ');
    console.log(' #+#           #+#     #+#        #+#   #+#+#     #+#          ');
    console.log('###       ########### ########## ###    #### ###########       ');
    console.log();
    console.log('===============================================================');
    console.log();
    console.log('An URLShortener with a small footprint, with node.js and redis.');
    console.log();
    console.log('===============================================================');
    console.log();
}