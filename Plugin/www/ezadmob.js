class ezadmob{
	//    static prepare(successCallback, errorCallback) {
	//            cordova.exec(successCallback, errorCallback, "ezadmob", "PREPARE_BANNER", []);
	//    };
	
		static init(successCallback, errorCallback, args) {
			cordova.exec(successCallback, errorCallback, "ezadmob", "INIT", args);
		};

		static showBanner(successCallback, errorCallback, pos) {
			if (pos === 'Overlay'){ 
				cordova.exec(successCallback, errorCallback, "ezadmob", "SHOW_OVERLAY_BANNER", []);
			} else {
				cordova.exec(successCallback, errorCallback, "ezadmob", "SHOW_CLIPPED_BANNER", []);
			}
		};
	
		static removeBanner(successCallback, errorCallback) {
			cordova.exec(successCallback, errorCallback, "ezadmob", "REMOVE_BANNER", []);
		};

		static showInterstitial(successCallback, errorCallback) {
			cordova.exec(successCallback, errorCallback, "ezadmob", "SHOW_INTERSTITIAL", []);
		};
	}
	