class ezadmob{
	static init(args) {
		cordova.exec(null, null, "ezadmob", "INIT", [args]);
	};

	static loadBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_AND_SHOW_BANNER");
	};

	static loadBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_BANNER");
	};

	static displayBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "DISPLAY_BANNER");
	};

	static removeBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "REMOVE_BANNER", []);
	};

	static loadInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_AND_SHOW_INTERSTITIAL", []);
	};

	static loadInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_INTERSTITIAL", []);
	};

	static displayInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "DISPLAY_INTERSTITIAL", []);
	};
}
	