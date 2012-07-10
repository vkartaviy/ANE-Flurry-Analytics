package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurrySetUserId implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String id = args[0].getAsString();
			FlurryAgent.setUserId( id );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
