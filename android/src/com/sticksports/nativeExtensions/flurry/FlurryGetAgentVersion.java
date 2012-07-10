package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurryGetAgentVersion implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			int version = FlurryAgent.getAgentVersion();
			String versionString = Integer.toString( version );
			return FREObject.newObject( versionString );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
