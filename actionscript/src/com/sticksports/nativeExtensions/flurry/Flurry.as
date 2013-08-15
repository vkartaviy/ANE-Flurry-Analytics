package com.sticksports.nativeExtensions.flurry
{
	import flash.external.ExtensionContext;

	public class Flurry
	{
		public static const GENDER_MALE : String = "m";
		public static const GENDER_FEMALE : String = "f";
		
		private static var extensionContext : ExtensionContext = null;
		
		private static function initExtension():void
		{
			if ( !extensionContext )
			{
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.Flurry", null );
			}
		}
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			initExtension();
			return extensionContext ? true : false;
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
			if( !_sessionStarted )
			{
				initExtension();
				extensionContext.call( NativeMethods.setAppVersion, version );
			}
		}
		
		/**
		 * The Flurry Agent version number. Should be called before start session.
		 */
		public static function get flurryAgentVersion() : String
		{
			initExtension();
			var version : String = String( extensionContext.call( NativeMethods.getFlurryAgentVersion ) );
			return version;
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
				initExtension();
				extensionContext.call( NativeMethods.setSessionContinueSeconds, seconds );
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
				initExtension();
				extensionContext.call( NativeMethods.setSecureTransportEnabled, value );
				_secureTransportEnabled = value;
			}
		}
		
		/**
		 * Start session, attempt to send saved sessions to the server.
		 */
		public static function startSession( id : String ) : void
		{
			initExtension();
			extensionContext.call( NativeMethods.startSession, id );
			_sessionStarted = true;
		}
		
		/**
		 * End session - android only.
		 */
		public static function endSession() : void
		{
			initExtension();
			extensionContext.call( NativeMethods.endSession );
			_sessionStarted = false;
		}
		
		/**
		 * Log events.
		 */
		public static function logEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( String( parameters[key] ) );
				}
				initExtension();
				extensionContext.call( NativeMethods.logEvent, eventName, array );
			}
			else
			{
				initExtension();
				extensionContext.call( NativeMethods.logEvent, eventName );
			}
		}
		
		/**
		 * Log errors.
		 */
		public static function logError( errorId : String, message : String ) : void
		{
			initExtension();
			extensionContext.call( NativeMethods.logError, errorId, message );
		}
		
		/**
		 * Log timed events.
		 */
		public static function startTimedEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( String( parameters[key] ) );
				}
				initExtension();
				extensionContext.call( NativeMethods.startTimedEvent, eventName, array );
			}
			else
			{
				initExtension();
				extensionContext.call( NativeMethods.startTimedEvent, eventName );
			}
		}
		
		/**
		 * Log timed events. Non-null parameters will updater the event parameters.
		 */
		public static function endTimedEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( String( parameters[key] ) );
				}
				initExtension();
				extensionContext.call( NativeMethods.endTimedEvent, eventName, array );
			}
			else
			{
				initExtension();
				extensionContext.call( NativeMethods.endTimedEvent, eventName );
			}
		}
		
		/**
		 * Set user's id in your system.
		 */
		public static function setUserId( id : String ) : void
		{
			initExtension();
			extensionContext.call( NativeMethods.setUserId, id );
		}
		
		/**
		 * Set user's age in years
		 */
		public static function setUserAge( age : int ) : void
		{
			initExtension();
			extensionContext.call( NativeMethods.setUserAge, age );
		}
		
		/**
		 * Set user's gender ("m" or "f")
		 */
		public static function setUserGender( gender : String ) : void
		{
			if( gender == GENDER_MALE || gender == GENDER_FEMALE )
			{
				initExtension();
				extensionContext.call( NativeMethods.setUserGender, gender );
			}
		}
		
		/**
		 * Set location information - iOS only
		 */
		public static function setLocation( latitude : Number, longitude : Number, horizontalAccuracy : Number, verticalAccuracy : Number ) : void
		{
			initExtension();
			extensionContext.call( NativeMethods.setLocation, latitude, longitude, horizontalAccuracy, verticalAccuracy );
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
			initExtension();
			extensionContext.call( NativeMethods.setEventLoggingEnabled, value );
			_eventLoggingEnabled = value;
		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			if( extensionContext )
			{
				extensionContext.dispose();
				extensionContext = null;
			}
		}
	}
}

