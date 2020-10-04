class ezadmob{
	static init(args) {
		cordova.exec(null, null, "ezadmob", "INIT", [args]);
	};

	static loadBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_BANNER");
	};

	static removeBanner(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "REMOVE_BANNER", []);
	};

	static loadInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_INTERSTITIAL", []);
	};

	static displayInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "DISPLAY_INTERSTITIAL", []);
	};
}
	