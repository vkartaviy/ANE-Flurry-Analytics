package com.sticksports.nativeExtensions.flurry
{
	internal class NativeMethods
	{
        internal static const setAppVersion : String = "flurry_setAppVersion";
        internal static const getFlurryAgentVersion : String = "flurry_getFlurryAgentVersion";
        internal static const setSessionContinueSeconds : String = "flurry_setSessionContinueSeconds";
        internal static const setSecureTransportEnabled : String = "flurry_setSecureTransportEnabled";
        internal static const startSession : String = "flurry_startSession";
        internal static const endSession : String = "flurry_endSession";
        internal static const logEvent : String = "flurry_logEvent";
        internal static const logError : String = "flurry_logError";
        internal static const startTimedEvent : String = "flurry_startTimedEvent";
        internal static const endTimedEvent : String = "flurry_endTimedEvent";
        internal static const setUserId : String = "flurry_setUserId";
        internal static const setUserAge : String = "flurry_setUserAge";
        internal static const setUserGender : String = "flurry_setUserGender";
        internal static const setLocation : String = "flurry_setLocation";
        internal static const setEventLoggingEnabled : String = "flurry_setEventLoggingEnabled";
	}
}
