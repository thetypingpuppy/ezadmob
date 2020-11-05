class ezadmob{
	static init(args) {
		cordova.exec(null, null, "ezadmob", "INIT", [args]);
	};

	static requestIDFA(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "REQUEST_IDFA");
	};

	static loadAndShowBanner(successCallback, errorCallback) {
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

	static loadAndShowInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_AND_SHOW_INTERSTITIAL", []);
	};

	static loadInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "LOAD_INTERSTITIAL", []);
	};

	static displayInterstitial(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "ezadmob", "DISPLAY_INTERSTITIAL", []);
	};
}
	