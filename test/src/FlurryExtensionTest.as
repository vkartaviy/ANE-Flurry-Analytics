package
{
	import com.sticksports.nativeExtensions.flurry.Flurry;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]

	public class FlurryExtensionTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;

		private var buttonFormat : TextFormat;
		
		private var eventName : String = "testEvent";
		private var paramEventName : String = "testParamEvent";
		private var timedEventName : String = "timedEvent";
		private var errorName : String = "testError";
		private var errorId : String = "1";
		
		private var iosFlurryId : String = "QDZNCV5C7P3XCR2S4KV4";
		private var androidFlurryId : String = "5WJJ44XFBYVMB4KHPBV9";
		
		public function get flurryId() : String
		{
			var os : String = Capabilities.version.substr(0,3);
			if( os == "IOS" )
			{
				return iosFlurryId;
			}
			else if( os == "AND" )
			{
				return androidFlurryId;
			}
			else
			{
				return "";
			}
		}

		public function FlurryExtensionTest()
		{
			shape = new Shape();
			shape.graphics.beginFill( 0x666666 );
			shape.graphics.drawCircle( 0, 0, 100 );
			shape.graphics.endFill();
			shape.x = 0;
			shape.y = 240;
			addChild( shape );

			feedback = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = "_sans";
			format.size = 16;
			format.color = 0xFFFFFF;
			feedback.defaultTextFormat = format;
			feedback.width = 320;
			feedback.height = 260;
			feedback.x = 10;
			feedback.y = 170;
			feedback.multiline = true;
			feedback.wordWrap = true;
			addChild( feedback );

			addEventListener( Event.ENTER_FRAME, animate );

			createButtons();
		}

		private function createButtons() : void
		{
			var tf : TextField = createButton( "startSession" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, startSession );
			addChild( tf );

			tf = createButton( "endSession" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, endSession );
			addChild( tf );

			tf = createButton( "flurryAgentVersion" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getFlurryVersion );
			addChild( tf );

			tf = createButton( "logEvent" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, logEvent );
			addChild( tf );

			tf = createButton( "logEventWithParams" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, logEventWithParams );
			addChild( tf );

			tf = createButton( "logError" );
			tf.x = 170;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, logError );
			addChild( tf );

			tf = createButton( "startTimedEvent" );
			tf.x = 10;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, startTimedEvent );
			addChild( tf );

			tf = createButton( "endTimedEvent" );
			tf.x = 170;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, endTimedEvent );
			addChild( tf );
		}

		private function createButton( label : String ) : TextField
		{
			if ( !buttonFormat )
			{
				buttonFormat = new TextFormat();
				buttonFormat.font = "_sans";
				buttonFormat.size = 14;
				buttonFormat.bold = true;
				buttonFormat.color = 0xFFFFFF;
				buttonFormat.align = TextFormatAlign.CENTER;
			}

			var textField : TextField = new TextField();
			textField.defaultTextFormat = buttonFormat;
			textField.width = 140;
			textField.height = 30;
			textField.text = label;
			textField.backgroundColor = 0xCC0000;
			textField.background = true;
			textField.selectable = false;
			textField.multiline = false;
			textField.wordWrap = false;
			return textField;
		}

		private function startSession( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.startSession( flurryId )";
			Flurry.startSession( flurryId );
		}

		private function endSession( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.endSession()";
			Flurry.endSession();
		}

		private function getFlurryVersion( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.flurryAgentVersion";
			feedback.appendText( "\n" + Flurry.flurryAgentVersion );
		}

		private function logEvent( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.logEvent( eventName )";
			Flurry.logEvent( eventName );
		}

		private function logEventWithParams( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.logEvent( paramEventName, {...} )";
			Flurry.logEvent( paramEventName, { size : Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY, dpi : Capabilities.screenDPI } );
		}

		private function logError( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.logError( errorId, errorName )";
			Flurry.logError( errorId, errorName );
		}

		private function startTimedEvent( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.startTimedEvent( timedEventName )";
			Flurry.startTimedEvent( timedEventName );
		}

		private function endTimedEvent( event : MouseEvent ) : void
		{
			feedback.text = "Flurry.endTimedEvent( timedEventName )";
			Flurry.endTimedEvent( timedEventName );
		}

		private function animate( event : Event ) : void
		{
			shape.x += direction;
			if ( shape.x <= 0 )
			{
				direction = 1;
			}
			if ( shape.x > 320 )
			{
				direction = -1;
			}
		}
	}
}