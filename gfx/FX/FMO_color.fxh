Includes = {
	"standardfuncsgfx.fxh"
}

Code
[[
	// Functions for the color of the big character focus buttons


	float3 FMO_DisableColor( float3 Color )
	{
		return Color *= 0.65;
	}
	// Approximates luminance from an RGB value
	float CalcLuminance(float3 color)
	{
	    return dot(color, float3(0.299f, 0.587f, 0.114f));
	}
	float3 FMO_SelectedColor( float3 Color )
	{
		float LocalTime = (GlobalTime / 3);
		Color.rgb *= 1.0f + pow( sin( LocalTime * 2 ) * 0.5f + 0.5f, 0.5 ) * 0.5f;
		float luminance = CalcLuminance(Color);
		if (luminance > 0.5)
		{
			Color *= 0.7;
		}
		if (luminance < 0.2)
		{
			Color *= 0.1;
		}
		return Color;
	}
	float4 FMO_SelectedGlow( VS_OUTPUT_PDX_GUI Input, float4 OutColor )
	{
		float value = dot(float3(1, 1, 1) / 3, OutColor.xyz);
		float f = sin(GlobalTime * -1 * (1.0f + 0.0001 * abs(sin(Input.Position.y * 0.02))) + Input.Position.x * 0.06 + 0.5 * sin(Input.Position.y * 0.02));
		f *= f;
		f *= 1.0 - value;
		f *= f;
		float outerness = 1.0f - 2.0f * min(min(min(Input.UV0.x, Input.UV0.y), 1.0f - Input.UV0.x), 1.0f - Input.UV0.y);
		f *= outerness;
		f = lerp(0.75f, 1.0f, 1.0 - f);
		OutColor.xyz *= f;
		OutColor.xyz += lerp(0.08f, 0.25f, outerness) * float3(1.0f, 1.0f, 0.5f) * value * value * max(0.0, sin(GlobalTime * -3.3 + Input.Position.x * 0.12 + Input.Position.y * 0.14 + 0.51 * sin(Input.Position.y * 0.011)));
		return OutColor *= 1.075;
	}
]]