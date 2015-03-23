/*!
 * modernizr v3.0.0-alpha.3
 * Build http://v3.modernizr.com/download/#-appearance-bgpositionxy-bgsizecover-canvas-classlist-cssanimations-csscalc-cssfilters-flexbox-fontface-fullscreen-history-inlinesvg-lastchild-localstorage-microdata-nthchild-picture-queryselector-rgba-svg-svgclippaths-touchevents-video-shiv-dontmin
 *
 * Copyright (c)
 *  Faruk Ates
 *  Paul Irish
 *  Alex Sexton
 *  Ryan Seddon
 *  Alexander Farkas
 *  Patrick Kettner
 *  Stu Cox
 *  Richard Herrera

 * MIT License
 */

/*
 * Modernizr tests which native CSS3 and HTML5 features are available in the
 * current UA and makes the results available to you in two ways: as properties on
 * a global `Modernizr` object, and as classes on the `<html>` element. This
 * information allows you to progressively enhance your pages with a granular level
 * of control over the experience.
 */

;(function(window, document, undefined){
    var classes = [];


    // Take the html5 variable out of the
    // html5shiv scope so we can return it.
    var html5;
    /**
     * @preserve HTML5 Shiv 3.7.2 | @afarkas @jdalton @jon_neal @rem | MIT/GPL2 Licensed
     */
    ;(function(window, document) {
        /*jshint evil:true */
        /** version */
        var version = '3.7.2';

        /** Preset options */
        var options = window.html5 || {};

        /** Used to skip problem elements */
        var reSkip = /^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i;

        /** Not all elements can be cloned in IE **/
        var saveClones = /^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i;

        /** Detect whether the browser supports default html5 styles */
        var supportsHtml5Styles;

        /** Name of the expando, to work with multiple documents or to re-shiv one document */
        var expando = '_html5shiv';

        /** The id for the the documents expando */
        var expanID = 0;

        /** Cached data for each document */
        var expandoData = {};

        /** Detect whether the browser supports unknown elements */
        var supportsUnknownElements;

        (function() {
            try {
                var a = document.createElement('a');
                a.innerHTML = '<xyz></xyz>';
                //if the hidden property is implemented we can assume, that the browser supports basic HTML5 Styles
                supportsHtml5Styles = ('hidden' in a);

                supportsUnknownElements = a.childNodes.length == 1 || (function() {
                    // assign a false positive if unable to shiv
                    (document.createElement)('a');
                    var frag = document.createDocumentFragment();
                    return (
                    typeof frag.cloneNode == 'undefined' ||
                    typeof frag.createDocumentFragment == 'undefined' ||
                    typeof frag.createElement == 'undefined'
                    );
                }());
            } catch(e) {
                // assign a false positive if detection fails => unable to shiv
                supportsHtml5Styles = true;
                supportsUnknownElements = true;
            }

        }());

        /*--------------------------------------------------------------------------*/

        /**
         * Creates a style sheet with the given CSS text and adds it to the document.
         * @private
         * @param {Document} ownerDocument The document.
         * @param {String} cssText The CSS text.
         * @returns {StyleSheet} The style element.
         */
        function addStyleSheet(ownerDocument, cssText) {
            var p = ownerDocument.createElement('p'),
                parent = ownerDocument.getElementsByTagName('head')[0] || ownerDocument.documentElement;

            p.innerHTML = 'x<style>' + cssText + '</style>';
            return parent.insertBefore(p.lastChild, parent.firstChild);
        }

        /**
         * Returns the value of `html5.elements` as an array.
         * @private
         * @returns {Array} An array of shived element node names.
         */
        function getElements() {
            var elements = html5.elements;
            return typeof elements == 'string' ? elements.split(' ') : elements;
        }

        /**
         * Extends the built-in list of html5 elements
         * @memberOf html5
         * @param {String|Array} newElements whitespace separated list or array of new element names to shiv
         * @param {Document} ownerDocument The context document.
         */
        function addElements(newElements, ownerDocument) {
            var elements = html5.elements;
            if(typeof elements != 'string'){
                elements = elements.join(' ');
            }
            if(typeof newElements != 'string'){
                newElements = newElements.join(' ');
            }
            html5.elements = elements +' '+ newElements;
            shivDocument(ownerDocument);
        }

        /**
         * Returns the data associated to the given document
         * @private
         * @param {Document} ownerDocument The document.
         * @returns {Object} An object of data.
         */
        function getExpandoData(ownerDocument) {
            var data = expandoData[ownerDocument[expando]];
            if (!data) {
                data = {};
                expanID++;
                ownerDocument[expando] = expanID;
                expandoData[expanID] = data;
            }
            return data;
        }

        /**
         * returns a shived element for the given nodeName and document
         * @memberOf html5
         * @param {String} nodeName name of the element
         * @param {Document} ownerDocument The context document.
         * @returns {Object} The shived element.
         */
        function createElement(nodeName, ownerDocument, data){
            if (!ownerDocument) {
                ownerDocument = document;
            }
            if(supportsUnknownElements){
                return ownerDocument.createElement(nodeName);
            }
            if (!data) {
                data = getExpandoData(ownerDocument);
            }
            var node;

            if (data.cache[nodeName]) {
                node = data.cache[nodeName].cloneNode();
            } else if (saveClones.test(nodeName)) {
                node = (data.cache[nodeName] = data.createElem(nodeName)).cloneNode();
            } else {
                node = data.createElem(nodeName);
            }

            // Avoid adding some elements to fragments in IE < 9 because
            // * Attributes like `name` or `type` cannot be set/changed once an element
            //   is inserted into a document/fragment
            // * Link elements with `src` attributes that are inaccessible, as with
            //   a 403 response, will cause the tab/window to crash
            // * Script elements appended to fragments will execute when their `src`
            //   or `text` property is set
            return node.canHaveChildren && !reSkip.test(nodeName) && !node.tagUrn ? data.frag.appendChild(node) : node;
        }

        /**
         * returns a shived DocumentFragment for the given document
         * @memberOf html5
         * @param {Document} ownerDocument The context document.
         * @returns {Object} The shived DocumentFragment.
         */
        function createDocumentFragment(ownerDocument, data){
            if (!ownerDocument) {
                ownerDocument = document;
            }
            if(supportsUnknownElements){
                return ownerDocument.createDocumentFragment();
            }
            data = data || getExpandoData(ownerDocument);
            var clone = data.frag.cloneNode(),
                i = 0,
                elems = getElements(),
                l = elems.length;
            for(;i<l;i++){
                clone.createElement(elems[i]);
            }
            return clone;
        }

        /**
         * Shivs the `createElement` and `createDocumentFragment` methods of the document.
         * @private
         * @param {Document|DocumentFragment} ownerDocument The document.
         * @param {Object} data of the document.
         */
        function shivMethods(ownerDocument, data) {
            if (!data.cache) {
                data.cache = {};
                data.createElem = ownerDocument.createElement;
                data.createFrag = ownerDocument.createDocumentFragment;
                data.frag = data.createFrag();
            }


            ownerDocument.createElement = function(nodeName) {
                //abort shiv
                if (!html5.shivMethods) {
                    return data.createElem(nodeName);
                }
                return createElement(nodeName, ownerDocument, data);
            };

            ownerDocument.createDocumentFragment = Function('h,f', 'return function(){' +
                'var n=f.cloneNode(),c=n.createElement;' +
                'h.shivMethods&&(' +
                    // unroll the `createElement` calls
                getElements().join().replace(/[\w\-:]+/g, function(nodeName) {
                    data.createElem(nodeName);
                    data.frag.createElement(nodeName);
                    return 'c("' + nodeName + '")';
                }) +
                ');return n}'
            )(html5, data.frag);
        }

        /*--------------------------------------------------------------------------*/

        /**
         * Shivs the given document.
         * @memberOf html5
         * @param {Document} ownerDocument The document to shiv.
         * @returns {Document} The shived document.
         */
        function shivDocument(ownerDocument) {
            if (!ownerDocument) {
                ownerDocument = document;
            }
            var data = getExpandoData(ownerDocument);

            if (html5.shivCSS && !supportsHtml5Styles && !data.hasCSS) {
                data.hasCSS = !!addStyleSheet(ownerDocument,
                    // corrects block display not defined in IE6/7/8/9
                    'article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}' +
                        // adds styling not present in IE6/7/8/9
                    'mark{background:#FF0;color:#000}' +
                        // hides non-rendered elements
                    'template{display:none}'
                );
            }
            if (!supportsUnknownElements) {
                shivMethods(ownerDocument, data);
            }
            return ownerDocument;
        }

        /*--------------------------------------------------------------------------*/

        /**
         * The `html5` object is exposed so that more elements can be shived and
         * existing shiving can be detected on iframes.
         * @type Object
         * @example
         *
         * // options can be changed before the script is included
         * html5 = { 'elements': 'mark section', 'shivCSS': false, 'shivMethods': false };
         */
        var html5 = {

            /**
             * An array or space separated string of node names of the elements to shiv.
             * @memberOf html5
             * @type Array|String
             */
            'elements': options.elements || 'abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output picture progress section summary template time video',

            /**
             * current version of html5shiv
             */
            'version': version,

            /**
             * A flag to indicate that the HTML5 style sheet should be inserted.
             * @memberOf html5
             * @type Boolean
             */
            'shivCSS': (options.shivCSS !== false),

            /**
             * Is equal to true if a browser supports creating unknown/HTML5 elements
             * @memberOf html5
             * @type boolean
             */
            'supportsUnknownElements': supportsUnknownElements,

            /**
             * A flag to indicate that the document's `createElement` and `createDocumentFragment`
             * methods should be overwritten.
             * @memberOf html5
             * @type Boolean
             */
            'shivMethods': (options.shivMethods !== false),

            /**
             * A string to describe the type of `html5` object ("default" or "default print").
             * @memberOf html5
             * @type String
             */
            'type': 'default',

            // shivs the document according to the specified `html5` object options
            'shivDocument': shivDocument,

            //creates a shived element
            createElement: createElement,

            //creates a shived documentFragment
            createDocumentFragment: createDocumentFragment,

            //extends list of elements
            addElements: addElements
        };

        /*--------------------------------------------------------------------------*/

        // expose html5
        window.html5 = html5;

        // shiv the document
        shivDocument(document);

    }(this, document));


    var tests = [];


    var ModernizrProto = {
        // The current version, dummy
        _version: '3.0.0-alpha.3',

        // Any settings that don't work as separate modules
        // can go in here as configuration.
        _config: {
            'classPrefix' : 'can-',
            'enableClasses' : true,
            'enableJSClass' : true,
            'usePrefixes' : true
        },

        // Queue of tests
        _q: [],

        // Stub these for people who are listening
        on: function( test, cb ) {
            // I don't really think people should do this, but we can
            // safe guard it a bit.
            // -- NOTE:: this gets WAY overridden in src/addTest for
            // actual async tests. This is in case people listen to
            // synchronous tests. I would leave it out, but the code
            // to *disallow* sync tests in the real version of this
            // function is actually larger than this.
            var self = this;
            setTimeout(function() {
                cb(self[test]);
            }, 0);
        },

        addTest: function( name, fn, options ) {
            tests.push({name : name, fn : fn, options : options });
        },

        addAsyncTest: function (fn) {
            tests.push({name : null, fn : fn});
        }
    };



    // Fake some of Object.create
    // so we can force non test results
    // to be non "own" properties.
    var Modernizr = function(){};
    Modernizr.prototype = ModernizrProto;

    // Leak modernizr globally when you `require` it
    // rather than force it here.
    // Overwrite name so constructor name is nicer :D
    Modernizr = new Modernizr();


    /*!
     {
     "name": "History API",
     "property": "history",
     "caniuse": "history",
     "tags": ["history"],
     "authors": ["Hay Kranen", "Alexander Farkas"],
     "notes": [{
     "name": "W3C Spec",
     "href": "http://www.w3.org/TR/html51/browsers.html#the-history-interface"
     }, {
     "name": "MDN documentation",
     "href": "https://developer.mozilla.org/en-US/docs/Web/API/window.history"
     }],
     "polyfills": ["historyjs", "html5historyapi"]
     }
     !*/
    /* DOC
     Detects support for the History API for manipulating the browser session history.
     */

    Modernizr.addTest('history', function() {
        // Issue #733
        // The stock browser on Android 2.2 & 2.3, and 4.0.x returns positive on history support
        // Unfortunately support is really buggy and there is no clean way to detect
        // these bugs, so we fall back to a user agent sniff :(
        var ua = navigator.userAgent;

        // We only want Android 2 and 4.0, stock browser, and not Chrome which identifies
        // itself as 'Mobile Safari' as well, nor Windows Phone (issue #1471).
        if ((ua.indexOf('Android 2.') !== -1 ||
            (ua.indexOf('Android 4.0') !== -1)) &&
            ua.indexOf('Mobile Safari') !== -1 &&
            ua.indexOf('Chrome') === -1 &&
            ua.indexOf('Windows Phone') === -1) {
            return false;
        }

        // Return the regular check
        return (window.history && 'pushState' in window.history);
    });

    /*!
     {
     "name": "Local Storage",
     "property": "localstorage",
     "caniuse": "namevalue-storage",
     "tags": ["storage"],
     "knownBugs": [],
     "notes": [],
     "warnings": [],
     "polyfills": [
     "joshuabell-polyfill",
     "cupcake",
     "storagepolyfill",
     "amplifyjs",
     "yui-cacheoffline"
     ]
     }
     !*/

    // In FF4, if disabled, window.localStorage should === null.

    // Normally, we could not test that directly and need to do a
    //   `('localStorage' in window) && ` test first because otherwise Firefox will
    //   throw bugzil.la/365772 if cookies are disabled

    // Also in iOS5 Private Browsing mode, attempting to use localStorage.setItem
    // will throw the exception:
    //   QUOTA_EXCEEDED_ERRROR DOM Exception 22.
    // Peculiarly, getItem and removeItem calls do not throw.

    // Because we are forced to try/catch this, we'll go aggressive.

    // Just FWIW: IE8 Compat mode supports these features completely:
    //   www.quirksmode.org/dom/html5.html
    // But IE8 doesn't support either with local files

    Modernizr.addTest('localstorage', function() {
        var mod = 'modernizr';
        try {
            localStorage.setItem(mod, mod);
            localStorage.removeItem(mod);
            return true;
        } catch(e) {
            return false;
        }
    });

    /*!
     {
     "name": "microdata",
     "property": "microdata",
     "tags": ["dom"],
     "builderAliases": ["dom_microdata"],
     "notes": [{
     "name": "W3 Spec",
     "href": "http://www.w3.org/TR/html5/microdata.html"
     }]
     }
     !*/

    Modernizr.addTest('microdata', 'getItems' in document);

    /*!
     {
     "name": "picture Element",
     "property": "picture",
     "tags": ["elem"],
     "authors": ["Scott Jehl", "Mat Marquis"],
     "notes": [{
     "name": "Specification",
     "href": "http://picture.responsiveimages.org"
     },{
     "name": "Relevant spec issue",
     "href": "https://github.com/ResponsiveImagesCG/picture-element/issues/87"
     }]
     }
     !*/

    Modernizr.addTest('picture', 'HTMLPictureElement' in window );

    /*!
     {
     "name": "QuerySelector",
     "property": "queryselector",
     "caniuse": "queryselector",
     "tags": ["queryselector"],
     "authors": ["Andrew Betts (@triblondon)"],
     "notes": [{
     "name" : "W3C Selectors reference",
     "href": "http://www.w3.org/TR/selectors-api/#queryselectorall"
     }],
     "polyfills": ["css-selector-engine"]
     }
     !*/
    /* DOC
     Detects support for querySelector.
     */

    Modernizr.addTest('queryselector', 'querySelector' in document && 'querySelectorAll' in document);

    /*!
     {
     "name": "SVG",
     "property": "svg",
     "caniuse": "svg",
     "tags": ["svg"],
     "authors": ["Erik Dahlstrom"],
     "polyfills": [
     "svgweb",
     "raphael",
     "amplesdk",
     "canvg",
     "svg-boilerplate",
     "sie",
     "dojogfx",
     "fabricjs"
     ]
     }
     !*/
    /* DOC
     Detects support for SVG in `<embed>` or `<object>` elements.
     */

    Modernizr.addTest('svg', !!document.createElementNS && !!document.createElementNS('http://www.w3.org/2000/svg', 'svg').createSVGRect);


    /**
     * is returns a boolean for if typeof obj is exactly type.
     */
    function is( obj, type ) {
        return typeof obj === type;
    }
    ;

    // Run through all tests and detect their support in the current UA.
    function testRunner() {
        var featureNames;
        var feature;
        var aliasIdx;
        var result;
        var nameIdx;
        var featureName;
        var featureNameSplit;

        for ( var featureIdx in tests ) {
            featureNames = [];
            feature = tests[featureIdx];
            // run the test, throw the return value into the Modernizr,
            //   then based on that boolean, define an appropriate className
            //   and push it into an array of classes we'll join later.
            //
            //   If there is no name, it's an 'async' test that is run,
            //   but not directly added to the object. That should
            //   be done with a post-run addTest call.
            if ( feature.name ) {
                featureNames.push(feature.name.toLowerCase());

                if (feature.options && feature.options.aliases && feature.options.aliases.length) {
                    // Add all the aliases into the names list
                    for (aliasIdx = 0; aliasIdx < feature.options.aliases.length; aliasIdx++) {
                        featureNames.push(feature.options.aliases[aliasIdx].toLowerCase());
                    }
                }
            }

            // Run the test, or use the raw value if it's not a function
            result = is(feature.fn, 'function') ? feature.fn() : feature.fn;


            // Set each of the names on the Modernizr object
            for (nameIdx = 0; nameIdx < featureNames.length; nameIdx++) {
                featureName = featureNames[nameIdx];
                // Support dot properties as sub tests. We don't do checking to make sure
                // that the implied parent tests have been added. You must call them in
                // order (either in the test, or make the parent test a dependency).
                //
                // Cap it to TWO to make the logic simple and because who needs that kind of subtesting
                // hashtag famous last words
                featureNameSplit = featureName.split('.');

                if (featureNameSplit.length === 1) {
                    Modernizr[featureNameSplit[0]] = result;
                } else {
                    // cast to a Boolean, if not one already
                    /* jshint -W053 */
                    if (Modernizr[featureNameSplit[0]] && !(Modernizr[featureNameSplit[0]] instanceof Boolean)) {
                        Modernizr[featureNameSplit[0]] = new Boolean(Modernizr[featureNameSplit[0]]);
                    }

                    Modernizr[featureNameSplit[0]][featureNameSplit[1]] = result;
                }

                classes.push((result ? '' : 'no-') + featureNameSplit.join('-'));
            }
        }
    }

    ;

    var docElement = document.documentElement;


    // Pass in an and array of class names, e.g.:
    //  ['no-webp', 'borderradius', ...]
    function setClasses( classes ) {
        var className = docElement.className;
        var classPrefix = Modernizr._config.classPrefix || '';

        // Change `no-js` to `js` (we do this independently of the `enableClasses`
        // option)
        // Handle classPrefix on this too
        if(Modernizr._config.enableJSClass) {
            var reJS = new RegExp('(^|\\s)'+classPrefix+'no-js(\\s|$)');
            className = className.replace(reJS, '$1'+classPrefix+'js$2');
        }

        if(Modernizr._config.enableClasses) {
            // Add the new classes
            className += ' ' + classPrefix + classes.join(' ' + classPrefix);
            docElement.className = className;
        }

    }

    ;
    /*!
     {
     "name": "classList",
     "caniuse": "classlist",
     "property": "classlist",
     "tags": ["dom"],
     "builderAliases": ["dataview_api"],
     "notes": [{
     "name": "MDN Docs",
     "href": "https://developer.mozilla.org/en/DOM/element.classList"
     }]
     }
     !*/

    Modernizr.addTest('classlist', 'classList' in docElement);


    var createElement = function() {
        if (typeof document.createElement !== 'function') {
            // This is the case in IE7, where the type of createElement is "object".
            // For this reason, we cannot call apply() as Object is not a Function.
            return document.createElement(arguments[0]);
        } else {
            return document.createElement.apply(document, arguments);
        }
    };

    /*!
     {
     "name": "Canvas",
     "property": "canvas",
     "caniuse": "canvas",
     "tags": ["canvas", "graphics"],
     "polyfills": ["flashcanvas", "excanvas", "slcanvas", "fxcanvas"]
     }
     !*/
    /* DOC
     Detects support for the `<canvas>` element for 2D drawing.
     */

    // On the S60 and BB Storm, getContext exists, but always returns undefined
    // so we actually have to call getContext() to verify
    // github.com/Modernizr/Modernizr/issues/issue/97/
    Modernizr.addTest('canvas', function() {
        var elem = createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    });

    /*!
     {
     "name": "CSS rgba",
     "caniuse": "css3-colors",
     "property": "rgba",
     "tags": ["css"],
     "notes": [{
     "name": "CSSTricks Tutorial",
     "href": "http://css-tricks.com/rgba-browser-support/"
     }]
     }
     !*/

    Modernizr.addTest('rgba', function() {
        var elem = createElement('div');
        var style = elem.style;
        style.cssText = 'background-color:rgba(150,255,150,.5)';

        return ('' + style.backgroundColor).indexOf('rgba') > -1;
    });

    /*!
     {
     "name": "HTML5 Video",
     "property": "video",
     "caniuse": "video",
     "tags": ["html5"],
     "knownBugs": [
     "Without QuickTime, `Modernizr.video.h264` will be `undefined`; http://github.com/Modernizr/Modernizr/issues/546"
     ],
     "polyfills": [
     "html5media",
     "mediaelementjs",
     "sublimevideo",
     "videojs",
     "leanbackplayer",
     "videoforeverybody"
     ]
     }
     !*/
    /* DOC
     Detects support for the video element, as well as testing what types of content it supports.

     Subproperties are provided to describe support for `ogg`, `h264` and `webm` formats, e.g.:

     ```javascript
     Modernizr.video         // true
     Modernizr.video.ogg     // 'probably'
     ```
     */

    // Codec values from : github.com/NielsLeenheer/html5test/blob/9106a8/index.html#L845
    //                     thx to NielsLeenheer and zcorpan

    // Note: in some older browsers, "no" was a return value instead of empty string.
    //   It was live in FF3.5.0 and 3.5.1, but fixed in 3.5.2
    //   It was also live in Safari 4.0.0 - 4.0.4, but fixed in 4.0.5

    Modernizr.addTest('video', function() {
        /* jshint -W053 */
        var elem = createElement('video');
        var bool = false;

        // IE9 Running on Windows Server SKU can cause an exception to be thrown, bug #224
        try {
            if ( bool = !!elem.canPlayType ) {
                bool = new Boolean(bool);
                bool.ogg = elem.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,'');

                // Without QuickTime, this value will be `undefined`. github.com/Modernizr/Modernizr/issues/546
                bool.h264 = elem.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,'');

                bool.webm = elem.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,'');

                bool.vp9 = elem.canPlayType('video/webm; codecs="vp9"').replace(/^no$/,'');

                bool.hls = elem.canPlayType('application/x-mpegURL; codecs="avc1.42E01E"').replace(/^no$/,'');
            }
        } catch(e){}

        return bool;
    });

    /*!
     {
     "name": "Inline SVG",
     "property": "inlinesvg",
     "caniuse": "svg-html5",
     "tags": ["svg"],
     "notes": [{
     "name": "Test page",
     "href": "http://paulirish.com/demo/inline-svg"
     }],
     "polyfills": ["inline-svg-polyfill"]
     }
     !*/
    /* DOC
     Detects support for inline SVG in HTML (not within XHTML).
     */

    Modernizr.addTest('inlinesvg', function() {
        var div = createElement('div');
        div.innerHTML = '<svg/>';
        return (div.firstChild && div.firstChild.namespaceURI) == 'http://www.w3.org/2000/svg';
    });


    // List of property values to set for css tests. See ticket #21
    var prefixes = (ModernizrProto._config.usePrefixes ? ' -webkit- -moz- -o- -ms- '.split(' ') : []);

    // expose these for the plugin API. Look in the source for how to join() them against your input
    ModernizrProto._prefixes = prefixes;


    /*!
     {
     "name": "CSS Calc",
     "property": "csscalc",
     "caniuse": "calc",
     "tags": ["css"],
     "builderAliases": ["css_calc"],
     "authors": ["@calvein"]
     }
     !*/
    /* DOC
     Method of allowing calculated values for length units. For example:

     ```css
     #elem {
     width: calc(100% - 3em);
     }
     ```
     */

    Modernizr.addTest('csscalc', function() {
        var prop = 'width:';
        var value = 'calc(10px);';
        var el = createElement('div');

        el.style.cssText = prop + prefixes.join(value + prop);

        return !!el.style.length;
    });

    /*!
     {
     "name": "CSS Supports",
     "property": "supports",
     "caniuse": "css-featurequeries",
     "tags": ["css"],
     "builderAliases": ["css_supports"],
     "notes": [{
     "name": "W3 Spec",
     "href": "http://dev.w3.org/csswg/css3-conditional/#at-supports"
     },{
     "name": "Related Github Issue",
     "href": "github.com/Modernizr/Modernizr/issues/648"
     },{
     "name": "W3 Info",
     "href": "http://dev.w3.org/csswg/css3-conditional/#the-csssupportsrule-interface"
     }]
     }
     !*/

    var newSyntax = 'CSS' in window && 'supports' in window.CSS;
    var oldSyntax = 'supportsCSS' in window;
    Modernizr.addTest('supports', newSyntax || oldSyntax);

    /*!
     {
     "name": "CSS Filters",
     "property": "cssfilters",
     "caniuse": "css-filters",
     "polyfills": ["polyfilter"],
     "tags": ["css"],
     "builderAliases": ["css_filters"],
     "notes": [{
     "name": "MDN article on CSS filters",
     "href": "https://developer.mozilla.org/en-US/docs/Web/CSS/filter"
     }]
     }
     !*/

    // https://github.com/Modernizr/Modernizr/issues/615
    // documentMode is needed for false positives in oldIE, please see issue above
    Modernizr.addTest('cssfilters', function() {
        var el = createElement('div');
        el.style.cssText = prefixes.join('filter:blur(2px); ');
        if (Modernizr.supports) {
            var supports = 'CSS' in window ?
                window.CSS.supports('filter', 'url()') :
                window.supportsCSS('filter', 'url()');

            // older firefox only supports `url` filters;
            return supports;
        } else {
            return !!el.style.length && ((document.documentMode === undefined || document.documentMode > 9));
        }
    });



    var toStringFn = ({}).toString;

    /*!
     {
     "name": "SVG clip paths",
     "property": "svgclippaths",
     "tags": ["svg"],
     "notes": [{
     "name": "Demo",
     "href": "http://srufaculty.sru.edu/david.dailey/svg/newstuff/clipPath4.svg"
     }]
     }
     !*/
    /* DOC
     Detects support for clip paths in SVG (only, not on HTML content).

     See [this discussion](http://github.com/Modernizr/Modernizr/issues/213) regarding applying SVG clip paths to HTML content.
     */

    Modernizr.addTest('svgclippaths', function() {
        return !!document.createElementNS &&
            /SVGClipPath/.test(toStringFn.call(document.createElementNS('http://www.w3.org/2000/svg', 'clipPath')));
    });


    // Following spec is to expose vendor-specific style properties as:
    //   elem.style.WebkitBorderRadius
    // and the following would be incorrect:
    //   elem.style.webkitBorderRadius

    // Webkit ghosts their properties in lowercase but Opera & Moz do not.
    // Microsoft uses a lowercase `ms` instead of the correct `Ms` in IE8+
    //   erik.eae.net/archives/2008/03/10/21.48.10/

    // More here: github.com/Modernizr/Modernizr/issues/issue/21
    var omPrefixes = 'Moz O ms Webkit';


    var domPrefixes = (ModernizrProto._config.usePrefixes ? omPrefixes.toLowerCase().split(' ') : []);
    ModernizrProto._domPrefixes = domPrefixes;


    // Helper function for converting kebab-case to camelCase,
    // e.g. box-sizing -> boxSizing
    function cssToDOM( name ) {
        return name.replace(/([a-z])-([a-z])/g, function(str, m1, m2) {
            return m1 + m2.toUpperCase();
        }).replace(/^-/, '');
    }
    ;

    function getBody() {
        // After page load injecting a fake body doesn't work so check if body exists
        var body = document.body;

        if(!body) {
            // Can't use the real body create a fake one.
            body = createElement('body');
            body.fake = true;
        }

        return body;
    }

    ;

    // Inject element with style element and some CSS rules
    function injectElementWithStyles( rule, callback, nodes, testnames ) {
        var mod = 'modernizr';
        var style;
        var ret;
        var node;
        var docOverflow;
        var div = createElement('div');
        var body = getBody();

        if ( parseInt(nodes, 10) ) {
            // In order not to give false positives we create a node for each test
            // This also allows the method to scale for unspecified uses
            while ( nodes-- ) {
                node = createElement('div');
                node.id = testnames ? testnames[nodes] : mod + (nodes + 1);
                div.appendChild(node);
            }
        }

        // <style> elements in IE6-9 are considered 'NoScope' elements and therefore will be removed
        // when injected with innerHTML. To get around this you need to prepend the 'NoScope' element
        // with a 'scoped' element, in our case the soft-hyphen entity as it won't mess with our measurements.
        // msdn.microsoft.com/en-us/library/ms533897%28VS.85%29.aspx
        // Documents served as xml will throw if using &shy; so use xml friendly encoded version. See issue #277
        style = ['&#173;','<style id="s', mod, '">', rule, '</style>'].join('');
        div.id = mod;
        // IE6 will false positive on some tests due to the style element inside the test div somehow interfering offsetHeight, so insert it into body or fakebody.
        // Opera will act all quirky when injecting elements in documentElement when page is served as xml, needs fakebody too. #270
        (!body.fake ? div : body).innerHTML += style;
        body.appendChild(div);
        if ( body.fake ) {
            //avoid crashing IE8, if background image is used
            body.style.background = '';
            //Safari 5.13/5.1.4 OSX stops loading if ::-webkit-scrollbar is used and scrollbars are visible
            body.style.overflow = 'hidden';
            docOverflow = docElement.style.overflow;
            docElement.style.overflow = 'hidden';
            docElement.appendChild(body);
        }

        ret = callback(div, rule);
        // If this is done after page load we don't want to remove the body so check if body exists
        if ( body.fake ) {
            body.parentNode.removeChild(body);
            docElement.style.overflow = docOverflow;
            // Trigger layout so kinetic scrolling isn't disabled in iOS6+
            docElement.offsetHeight;
        } else {
            div.parentNode.removeChild(div);
        }

        return !!ret;

    }

    ;

    var testStyles = ModernizrProto.testStyles = injectElementWithStyles;

    /*!
     {
     "name": "@font-face",
     "property": "fontface",
     "authors": ["Diego Perini", "Mat Marquis"],
     "tags": ["css"],
     "knownBugs": [
     "False Positive: WebOS http://github.com/Modernizr/Modernizr/issues/342",
     "False Postive: WP7 http://github.com/Modernizr/Modernizr/issues/538"
     ],
     "notes": [{
     "name": "@font-face detection routine by Diego Perini",
     "href": "http://javascript.nwbox.com/CSSSupport/"
     },{
     "name": "Filament Group @font-face compatibility research",
     "href": "https://docs.google.com/presentation/d/1n4NyG4uPRjAA8zn_pSQ_Ket0RhcWC6QlZ6LMjKeECo0/edit#slide=id.p"
     },{
     "name": "Filament Grunticon/@font-face device testing results",
     "href": "https://docs.google.com/spreadsheet/ccc?key=0Ag5_yGvxpINRdHFYeUJPNnZMWUZKR2ItMEpRTXZPdUE#gid=0"
     },{
     "name": "CSS fonts on Android",
     "href": "http://stackoverflow.com/questions/3200069/css-fonts-on-android"
     },{
     "name": "@font-face and Android",
     "href": "http://archivist.incutio.com/viewlist/css-discuss/115960"
     }]
     }
     !*/

    var blacklist = (function() {
        var ua = navigator.userAgent;
        var wkvers = ua.match( /applewebkit\/([0-9]+)/gi ) && parseFloat( RegExp.$1 );
        var webos = ua.match( /w(eb)?osbrowser/gi );
        var wppre8 = ua.match( /windows phone/gi ) && ua.match( /iemobile\/([0-9])+/gi ) && parseFloat( RegExp.$1 ) >= 9;
        var oldandroid = wkvers < 533 && ua.match( /android/gi );
        return webos || oldandroid || wppre8;
    }());
    if( blacklist ) {
        Modernizr.addTest('fontface', false);
    } else {
        testStyles('@font-face {font-family:"font";src:url("https://")}', function( node, rule ) {
            var style = document.getElementById('smodernizr');
            var sheet = style.sheet || style.styleSheet;
            var cssText = sheet ? (sheet.cssRules && sheet.cssRules[0] ? sheet.cssRules[0].cssText : sheet.cssText || '') : '';
            var bool = /src/i.test(cssText) && cssText.indexOf(rule.split(' ')[0]) === 0;
            Modernizr.addTest('fontface', bool);
        });
    }
    ;
    /*!
     {
     "name": "CSS :last-child pseudo-selector",
     "caniuse": "css-sel3",
     "property": "lastchild",
     "tags": ["css"],
     "builderAliases": ["css_lastchild"],
     "notes": [{
     "name": "Related Github Issue",
     "href": "https://github.com/Modernizr/Modernizr/pull/304"
     }]
     }
     !*/

    testStyles('#modernizr div {width:100px} #modernizr :last-child{width:200px;display:block}', function( elem ) {
        Modernizr.addTest('lastchild', elem.lastChild.offsetWidth > elem.firstChild.offsetWidth);
    }, 2);

    /*!
     {
     "name": "CSS :nth-child pseudo-selector",
     "caniuse": "css-sel3",
     "property": "nthchild",
     "tags": ["css"],
     "notes": [
     {
     "name": "Related Github Issue",
     "href": "https://github.com/Modernizr/Modernizr/pull/685"
     },
     {
     "name": "Sitepoint :nth-child documentation",
     "href": "http://reference.sitepoint.com/css/pseudoclass-nthchild"
     }
     ],
     "authors": ["@emilchristensen"],
     "warnings": ["Known false negative in Safari 3.1 and Safari 3.2.2"]
     }
     !*/
    /* DOC
     Detects support for the ':nth-child()' CSS pseudo-selector.
     */

    // 5 `<div>` elements with `1px` width are created.
    // Then every other element has its `width` set to `2px`.
    // A Javascript loop then tests if the `<div>`s have the expected width
    // using the modulus operator.
    testStyles('#modernizr div {width:1px} #modernizr div:nth-child(2n) {width:2px;}', function( elem ) {
        Modernizr.addTest('nthchild', function() {
            var elems = elem.getElementsByTagName('div'),
                test = true;

            for (var i = 0; i < 5; i++) {
                test = test && elems[i].offsetWidth === i % 2 + 1;
            }

            return test;
        });
    }, 5);

    /*!
     {
     "name": "Touch Events",
     "property": "touchevents",
     "caniuse" : "touch",
     "tags": ["media", "attribute"],
     "notes": [{
     "name": "Touch Events spec",
     "href": "http://www.w3.org/TR/2013/WD-touch-events-20130124/"
     }],
     "warnings": [
     "Indicates if the browser supports the Touch Events spec, and does not necessarily reflect a touchscreen device"
     ],
     "knownBugs": [
     "False-positive on some configurations of Nokia N900",
     "False-positive on some BlackBerry 6.0 builds – https://github.com/Modernizr/Modernizr/issues/372#issuecomment-3112695"
     ]
     }
     !*/
    /* DOC
     Indicates if the browser supports the W3C Touch Events API.

     This *does not* necessarily reflect a touchscreen device:

     * Older touchscreen devices only emulate mouse events
     * Modern IE touch devices implement the Pointer Events API instead: use `Modernizr.pointerevents` to detect support for that
     * Some browsers & OS setups may enable touch APIs when no touchscreen is connected
     * Future browsers may implement other event models for touch interactions

     See this article: [You Can't Detect A Touchscreen](http://www.stucox.com/blog/you-cant-detect-a-touchscreen/).

     It's recommended to bind both mouse and touch/pointer events simultaneously – see [this HTML5 Rocks tutorial](http://www.html5rocks.com/en/mobile/touchandmouse/).

     This test will also return `true` for Firefox 4 Multitouch support.
     */

    // Chrome (desktop) used to lie about its support on this, but that has since been rectified: http://crbug.com/36415
    Modernizr.addTest('touchevents', function() {
        var bool;
        if(('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch) {
            bool = true;
        } else {
            var query = ['@media (',prefixes.join('touch-enabled),('),'heartz',')','{#modernizr{top:9px;position:absolute}}'].join('');
            testStyles(query, function( node ) {
                bool = node.offsetTop === 9;
            });
        }
        return bool;
    });


    var cssomPrefixes = (ModernizrProto._config.usePrefixes ? omPrefixes.split(' ') : []);
    ModernizrProto._cssomPrefixes = cssomPrefixes;


    /**
     * atRule returns a given CSS property at-rule (eg @keyframes), possibly in
     * some prefixed form, or false, in the case of an unsupported rule
     *
     * @param prop - String naming the property to test
     */

    var atRule = function(prop) {
        var length = prefixes.length;
        var cssrule = window.CSSRule;
        var rule;

        if (typeof cssrule === 'undefined') {
            return undefined;
        }

        if (!prop) {
            return false;
        }

        // remove literal @ from beginning of provided property
        prop = prop.replace(/^@/,'');

        // CSSRules use underscores instead of dashes
        rule = prop.replace(/-/g,'_').toUpperCase() + '_RULE';

        if (rule in cssrule) {
            return '@' + prop;
        }

        for ( var i = 0; i < length; i++ ) {
            // prefixes gives us something like -o-, and we want O_
            var prefix = prefixes[i];
            var thisRule = prefix.toUpperCase() + '_' + rule;

            if (thisRule in cssrule) {
                return '@-' + prefix.toLowerCase() + '-' + prop;
            }
        }

        return false;
    };



    /**
     * contains returns a boolean for if substr is found within str.
     */
    function contains( str, substr ) {
        return !!~('' + str).indexOf(substr);
    }

    ;

    // Change the function's scope.
    function fnBind(fn, that) {
        return function() {
            return fn.apply(that, arguments);
        };
    }

    ;

    /**
     * testDOMProps is a generic DOM property test; if a browser supports
     *   a certain property, it won't return undefined for it.
     */
    function testDOMProps( props, obj, elem ) {
        var item;

        for ( var i in props ) {
            if ( props[i] in obj ) {

                // return the property name as a string
                if (elem === false) return props[i];

                item = obj[props[i]];

                // let's bind a function
                if (is(item, 'function')) {
                    // bind to obj unless overriden
                    return fnBind(item, elem || obj);
                }

                // return the unbound function or obj or value
                return item;
            }
        }
        return false;
    }

    ;

    /**
     * Create our "modernizr" element that we do most feature tests on.
     */
    var modElem = {
        elem : createElement('modernizr')
    };

    // Clean up this element
    Modernizr._q.push(function() {
        delete modElem.elem;
    });



    var mStyle = {
        style : modElem.elem.style
    };

    // kill ref for gc, must happen before
    // mod.elem is removed, so we unshift on to
    // the front of the queue.
    Modernizr._q.unshift(function() {
        delete mStyle.style;
    });



    // Helper function for converting camelCase to kebab-case,
    // e.g. boxSizing -> box-sizing
    function domToCSS( name ) {
        return name.replace(/([A-Z])/g, function(str, m1) {
            return '-' + m1.toLowerCase();
        }).replace(/^ms-/, '-ms-');
    }
    ;

    // Function to allow us to use native feature detection functionality if available.
    // Accepts a list of property names and a single value
    // Returns `undefined` if native detection not available
    function nativeTestProps ( props, value ) {
        var i = props.length;
        // Start with the JS API: http://www.w3.org/TR/css3-conditional/#the-css-interface
        if ('CSS' in window && 'supports' in window.CSS) {
            // Try every prefixed variant of the property
            while (i--) {
                if (window.CSS.supports(domToCSS(props[i]), value)) {
                    return true;
                }
            }
            return false;
        }
        // Otherwise fall back to at-rule (for Opera 12.x)
        else if ('CSSSupportsRule' in window) {
            // Build a condition string for every prefixed variant
            var conditionText = [];
            while (i--) {
                conditionText.push('(' + domToCSS(props[i]) + ':' + value + ')');
            }
            conditionText = conditionText.join(' or ');
            return injectElementWithStyles('@supports (' + conditionText + ') { #modernizr { position: absolute; } }', function( node ) {
                return getComputedStyle(node, null).position == 'absolute';
            });
        }
        return undefined;
    }
    ;

    // testProps is a generic CSS / DOM property test.

    // In testing support for a given CSS property, it's legit to test:
    //    `elem.style[styleName] !== undefined`
    // If the property is supported it will return an empty string,
    // if unsupported it will return undefined.

    // We'll take advantage of this quick test and skip setting a style
    // on our modernizr element, but instead just testing undefined vs
    // empty string.

    // Property names can be provided in either camelCase or kebab-case.

    function testProps( props, prefixed, value, skipValueTest ) {
        skipValueTest = is(skipValueTest, 'undefined') ? false : skipValueTest;

        // Try native detect first
        if (!is(value, 'undefined')) {
            var result = nativeTestProps(props, value);
            if(!is(result, 'undefined')) {
                return result;
            }
        }

        // Otherwise do it properly
        var afterInit, i, propsLength, prop, before;

        // If we don't have a style element, that means
        // we're running async or after the core tests,
        // so we'll need to create our own elements to use
        if ( !mStyle.style ) {
            afterInit = true;
            mStyle.modElem = createElement('modernizr');
            mStyle.style = mStyle.modElem.style;
        }

        // Delete the objects if we
        // we created them.
        function cleanElems() {
            if (afterInit) {
                delete mStyle.style;
                delete mStyle.modElem;
            }
        }

        propsLength = props.length;
        for ( i = 0; i < propsLength; i++ ) {
            prop = props[i];
            before = mStyle.style[prop];

            if (contains(prop, '-')) {
                prop = cssToDOM(prop);
            }

            if ( mStyle.style[prop] !== undefined ) {

                // If value to test has been passed in, do a set-and-check test.
                // 0 (integer) is a valid property value, so check that `value` isn't
                // undefined, rather than just checking it's truthy.
                if (!skipValueTest && !is(value, 'undefined')) {

                    // Needs a try catch block because of old IE. This is slow, but will
                    // be avoided in most cases because `skipValueTest` will be used.
                    try {
                        mStyle.style[prop] = value;
                    } catch (e) {}

                    // If the property value has changed, we assume the value used is
                    // supported. If `value` is empty string, it'll fail here (because
                    // it hasn't changed), which matches how browsers have implemented
                    // CSS.supports()
                    if (mStyle.style[prop] != before) {
                        cleanElems();
                        return prefixed == 'pfx' ? prop : true;
                    }
                }
                // Otherwise just return true, or the property name if this is a
                // `prefixed()` call
                else {
                    cleanElems();
                    return prefixed == 'pfx' ? prop : true;
                }
            }
        }
        cleanElems();
        return false;
    }

    ;

    /**
     * testPropsAll tests a list of DOM properties we want to check against.
     *     We specify literally ALL possible (known and/or likely) properties on
     *     the element including the non-vendor prefixed one, for forward-
     *     compatibility.
     */
    function testPropsAll( prop, prefixed, elem, value, skipValueTest ) {

        var ucProp = prop.charAt(0).toUpperCase() + prop.slice(1),
            props = (prop + ' ' + cssomPrefixes.join(ucProp + ' ') + ucProp).split(' ');

        // did they call .prefixed('boxSizing') or are we just testing a prop?
        if(is(prefixed, 'string') || is(prefixed, 'undefined')) {
            return testProps(props, prefixed, value, skipValueTest);

            // otherwise, they called .prefixed('requestAnimationFrame', window[, elem])
        } else {
            props = (prop + ' ' + (domPrefixes).join(ucProp + ' ') + ucProp).split(' ');
            return testDOMProps(props, prefixed, elem);
        }
    }

    // Modernizr.testAllProps() investigates whether a given style property,
    //     or any of its vendor-prefixed variants, is recognized
    // Note that the property names must be provided in the camelCase variant.
    // Modernizr.testAllProps('boxSizing')
    ModernizrProto.testAllProps = testPropsAll;



    /**
     * testAllProps determines whether a given CSS property, in some prefixed
     * form, is supported by the browser. It can optionally be given a value; in
     * which case testAllProps will only return true if the browser supports that
     * value for the named property; this latter case will use native detection
     * (via window.CSS.supports) if available. A boolean can be passed as a 3rd
     * parameter to skip the value check when native detection isn't available,
     * to improve performance when simply testing for support of a property.
     *
     * @param prop - String naming the property to test (either camelCase or
     *               kebab-case)
     * @param value - [optional] String of the value to test
     * @param skipValueTest - [optional] Whether to skip testing that the value
     *                        is supported when using non-native detection
     *                        (default: false)
     */
    function testAllProps (prop, value, skipValueTest) {
        return testPropsAll(prop, undefined, undefined, value, skipValueTest);
    }
    ModernizrProto.testAllProps = testAllProps;

    /*!
     {
     "name": "Appearance",
     "property": "appearance",
     "caniuse": "css-appearance",
     "tags": ["css"],
     "notes": [{
     "name": "MDN documentation",
     "href": "https://developer.mozilla.org/en-US/docs/Web/CSS/-moz-appearance"
     },{
     "name": "CSS-Tricks CSS Almanac: appearance",
     "href": "http://css-tricks.com/almanac/properties/a/appearance/"
     }]
     }
     !*/
    /* DOC
     Detects support for the `appearance` css property, which is used to make an
     element inherit the style of a standard user interface element. It can also be
     used to remove the default styles of an element, such as input and buttons.
     */

    Modernizr.addTest('appearance', testAllProps('appearance'));

    /*!
     {
     "name": "Background Position XY",
     "property": "bgpositionxy",
     "tags": ["css"],
     "builderAliases": ["css_backgroundposition_xy"],
     "authors": ["Allan Lei", "Brandom Aaron"],
     "notes": [{
     "name": "Demo",
     "href": "http://jsfiddle.net/allanlei/R8AYS/"
     }, {
     "name": "Adapted From",
     "href": "https://github.com/brandonaaron/jquery-cssHooks/blob/master/bgpos.js"
     }]
     }
     !*/
    /* DOC
     Detects the ability to control an element's background position using css
     */

    Modernizr.addTest('bgpositionxy', function () {
        return testAllProps('backgroundPositionX', '3px', true) && testAllProps('backgroundPositionY', '5px', true);
    });

    /*!
     {
     "name": "Background Size Cover",
     "property": "bgsizecover",
     "tags": ["css"],
     "builderAliases": ["css_backgroundsizecover"],
     "notes": [{
     "name" : "MDN Docs",
     "href": "http://developer.mozilla.org/en/CSS/background-size"
     }]
     }
     !*/

    // Must test value, as this specifically tests the `cover` value
    Modernizr.addTest('bgsizecover', testAllProps('backgroundSize', 'cover'));

    /*!
     {
     "name": "CSS Animations",
     "property": "cssanimations",
     "caniuse": "css-animation",
     "polyfills": ["transformie", "csssandpaper"],
     "tags": ["css"],
     "warnings": ["Android < 4 will pass this test, but can only animate a single property at a time"],
     "notes": [{
     "name" : "Article: 'Dispelling the Android CSS animation myths'",
     "href": "http://goo.gl/OGw5Gm"
     }]
     }
     !*/
    /* DOC
     Detects whether or not elements can be animated using CSS
     */

    Modernizr.addTest('cssanimations', testAllProps('animationName', 'a', true));

    /*!
     {
     "name": "Flexbox",
     "property": "flexbox",
     "caniuse": "flexbox",
     "tags": ["css"],
     "notes": [{
     "name": "The _new_ flexbox",
     "href": "http://dev.w3.org/csswg/css3-flexbox"
     }],
     "warnings": [
     "A `true` result for this detect does not imply that the `flex-wrap` property is supported; see the `flexwrap` detect."
     ]
     }
     !*/
    /* DOC
     Detects support for the Flexible Box Layout model, a.k.a. Flexbox, which allows easy manipulation of layout order and sizing within a container.
     */

    Modernizr.addTest('flexbox', testAllProps('flexBasis', '1px', true));


    // Modernizr.prefixed() returns the prefixed or nonprefixed property name variant of your input
    // Modernizr.prefixed('boxSizing') // 'MozBoxSizing'

    // Properties can be passed as DOM-style camelCase or CSS-style kebab-case.
    // Return values will always be in camelCase; if you want kebab-case, use Modernizr.prefixedCSS().

    // If you're trying to ascertain which transition end event to bind to, you might do something like...
    //
    //     var transEndEventNames = {
    //         'WebkitTransition' : 'webkitTransitionEnd',// Saf 6, Android Browser
    //         'MozTransition'    : 'transitionend',      // only for FF < 15
    //         'transition'       : 'transitionend'       // IE10, Opera, Chrome, FF 15+, Saf 7+
    //     },
    //     transEndEventName = transEndEventNames[ Modernizr.prefixed('transition') ];

    var prefixed = ModernizrProto.prefixed = function( prop, obj, elem ) {
        if (prop.indexOf('@') === 0) {
            return atRule(prop);
        }

        if (prop.indexOf('-') != -1) {
            // Convert kebab-case to camelCase
            prop = cssToDOM(prop);
        }
        if (!obj) {
            return testPropsAll(prop, 'pfx');
        } else {
            // Testing DOM property e.g. Modernizr.prefixed('requestAnimationFrame', window) // 'mozRequestAnimationFrame'
            return testPropsAll(prop, obj, elem);
        }
    };


    /*!
     {
     "name": "Fullscreen API",
     "property": "fullscreen",
     "caniuse": "fullscreen",
     "notes": [{
     "name": "MDN documentation",
     "href": "https://developer.mozilla.org/en/API/Fullscreen"
     }],
     "polyfills": ["screenfulljs"],
     "builderAliases": ["fullscreen_api"]
     }
     !*/
    /* DOC
     Detects support for the ability to make the current website take over the user's entire screen
     */

    // github.com/Modernizr/Modernizr/issues/739
    Modernizr.addTest('fullscreen', !!(prefixed('exitFullscreen', document, false) || prefixed('cancelFullScreen', document, false)));


    // Run each test
    testRunner();

    // Remove the "no-js" class if it exists
    setClasses(classes);

    delete ModernizrProto.addTest;
    delete ModernizrProto.addAsyncTest;

    // Run the things that are supposed to run after the tests
    for (var i = 0; i < Modernizr._q.length; i++) {
        Modernizr._q[i]();
    }

    // Leak Modernizr namespace
    window.Modernizr = Modernizr;


    ;

})(window, document);