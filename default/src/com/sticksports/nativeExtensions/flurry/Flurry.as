package com.sticksports.nativeExtensions.flurry
{
	/**
	 * Default implementation
	 */
	public class Flurry
	{
		public static const GENDER_MALE : String = "m";
		public static const GENDER_FEMALE : String = "f";
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			return false;
		}
		
		private static var _sessionStarted : Boolean;
		private static var _sessionContinueSeconds : int = 10;
		private static var _secureTransportEnabled : Boolean = false;
		private static var _eventLoggingEnabled : Boolean = true;

		/**
		 * Override the app version. Should be called before start session.
		 */
		public static function setAppVersion( version : String ) : void
		{
		}
		
		/**
		 * The Flurry Agent version number. Should be called before start session.
		 */
		public static function get flurryAgentVersion() : String
		{
			return "0.0.0";
		}
		
		/**
		 * Should be called before start session. Default is 10.
		 */
		public static function get sessionContinueSeconds() : int
		{
			return _sessionContinueSeconds;
		}
		public static function set sessionContinueSeconds( seconds : int ) : void
		{
			if( !_sessionStarted )
			{
				_sessionContinueSeconds = seconds;
			}
		}
		
		/**
		 * Set data to be sent over SSL. Should be called before start session. Default is false.
		 */
		public static function get secureTransportEnabled() : Boolean
		{
			return _secureTransportEnabled;
		}
		public static function set secureTransportEnabled( value : Boolean ) : void
		{
			if( !_sessionStarted )
			{
				_secureTransportEnabled = value;
			}
		}
		
		/**
		 * Start session, attempt to send saved sessions to the server.
		 */
		public static function startSession( id : String ) : void
		{
			_sessionStarted = true;
		}
		
		/**
		 * End session - android only.
		 */
		public static function endSession() : void
		{
			_sessionStarted = false;
		}
		
		/**
		 * Log events.
		 */
		public static function logEvent( eventName : String, parameters : Object = null ) : void
		{
		}
		
		/**
		 * Log errors.
		 */
		public static function logError( errorId : String, message : String ) : void
		{
		}
		
		/**
		 * Log timed events.
		 */
		public static function startTimedEvent( eventName : String, parameters : Object = null ) : void
		{
		}
		
		/**
		 * Log timed events. Non-null parameters will updater the event parameters.
		 */
		public static function endTimedEvent( eventName : String, parameters : Object = null ) : void
		{
		}
		
		/**
		 * Set user's id in your system.
		 */
		public static function setUserId( id : String ) : void
		{
		}
		
		/**
		 * Set user's age in years
		 */
		public static function setUserAge( age : int ) : void
		{
		}
		
		/**
		 * Set user's gender ("m" or "f")
		 */
		public static function setUserGender( gender : String ) : void
		{
		}
		
		/**
		 * Set location information - iOS only
		 */
		public static function setLocation( latitude : Number, longitude : Number, horizontalAccuracy : Number, verticalAccuracy : Number ) : void
		{
		}
		
		/**
		 * Enable logging. Default is true.
		 */
		public static function get eventLoggingEnabled() : Boolean
		{
			return _eventLoggingEnabled;
		}
		public static function set eventLoggingEnabled( value : Boolean ) : void
		{
			_eventLoggingEnabled = value;
		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
		}
	}
}

