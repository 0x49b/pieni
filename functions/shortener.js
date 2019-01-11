// shortener.js
// ===============
module.exports = {
    /**
     * Checks if the generated Key is already used
     * @param key
     */
    checkExistingKey: function (key) {
        client.exists(key, function (err, reply) {
            if (reply === 1) {
                return true;
            }
        });
        return false
    },

    /**
     * Generates a new Key or if it is set by the User returns the chosen
     * @param key
     */
    generateKey: function (key = '') {
        if (key === "" || key === undefined || key === null) {
            key = Math.random().toString(36).substr(2, 5);
        }
        return key;
    },

    /**
     * Prints a fancy Header to the console on startup
     */
    printHead: function () {
        console.log('                                                                   ');
        console.log('                                                                   ');
        console.log('        ::::::::: ::::::::::: :::::::::: ::::    ::: :::::::::::   ');
        console.log('       :+:    :+:    :+:     :+:        :+:+:   :+:     :+:        ');
        console.log('      +:+    +:+    +:+     +:+        :+:+:+  +:+     +:+         ');
        console.log('     +#++:++#+     +#+     +#++:++#   +#+ +:+ +#+     +#+          ');
        console.log('    +#+           +#+     +#+        +#+  +#+#+#     +#+           ');
        console.log('   #+#           #+#     #+#        #+#   #+#+#     #+#            ');
        console.log('  ###       ########### ########## ###    #### ###########         ');
        console.log('                                                                   ');
        console.log('  ===============================================================  ');
        console.log('                                                                   ');
        console.log('               An URLShortener with a small footprint.             ');
        console.log('                   Made with ❤️, node.js and redis.                ');
        console.log('                         by lichtwellenreiter.                     ');
        console.log('                                                                   ');
        console.log('  ===============================================================  ');
        console.log('                                                                   ');
    }
};