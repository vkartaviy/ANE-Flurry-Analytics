package com.sticksports.nativeExtensions.flurry;

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurryLogEvent implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String event = args[0].getAsString();
			if( args.length == 2 )
			{
		        FREArray array = ( FREArray )args[1];
		        long length = array.getLength();
		        long count = length >> 1;
		        if( count > 0 )
		        {
		        	Map<String, String> parameters = new HashMap<String, String>();
		            long i;
		            for( i = 0; i < count; ++i )
		            {
		            	String key = array.getObjectAt( i * 2 ).getAsString();
		            	String value = array.getObjectAt( i * 2 + 1 ).getAsString();
		                parameters.put(  key, value );
		            }
		            FlurryAgent.logEvent( event, parameters );
		        }
		        else
		        {
		        	FlurryAgent.logEvent( event );
		        }
			}
			else
			{
				FlurryAgent.logEvent( event );
			}
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}

}

