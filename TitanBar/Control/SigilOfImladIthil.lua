-- Sigil of Imlad Ithil.lua
-- Written by Kaische


_G.SOII = {}; -- Sigil of Imlad Ithil table in _G

--**v Control of Sigil of Imlad Ithil v**
SOII["Ctr"] = Turbine.UI.Control();
SOII["Ctr"]:SetParent( TB["win"] );
SOII["Ctr"]:SetMouseVisible( false );
SOII["Ctr"]:SetZOrder( 2 );
SOII["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
SOII["Ctr"]:SetBackColor( Turbine.UI.Color( SOIIbcAlpha, SOIIbcRed, SOIIbcGreen, SOIIbcBlue ) );
--**^
--**v Sigil of Imlad Ithil & icon on TitanBar v**
SOII["Icon"] = Turbine.UI.Control();
SOII["Icon"]:SetParent( SOII["Ctr"] );
SOII["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
SOII["Icon"]:SetSize( 32, 32 );
SOII["Icon"]:SetBackground( WalletItem.SigilOfImladIthil.Icon );-- in-game icon 32x32
--**^

SOII["Icon"].MouseMove = function( sender, args )
	SOII["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveSOIICtr(sender, args); end
end

SOII["Icon"].MouseLeave = function( sender, args )
	SOII["Lbl"].MouseLeave( sender, args );
end

SOII["Icon"].MouseClick = function( sender, args )
	SOII["Lbl"].MouseClick( sender, args );
end

SOII["Icon"].MouseDown = function( sender, args )
	SOII["Lbl"].MouseDown( sender, args );
end

SOII["Icon"].MouseUp = function( sender, args )
	SOII["Lbl"].MouseUp( sender, args );
end


SOII["Lbl"] = Turbine.UI.Label();
SOII["Lbl"]:SetParent( SOII["Ctr"] );
SOII["Lbl"]:SetFont( _G.TBFont );
SOII["Lbl"]:SetPosition( 0, 0 );
SOII["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
SOII["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

SOII["Lbl"].MouseMove = function( sender, args )
	SOII["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveSOIICtr(sender, args);
	else
		ShowToolTipWin( "SOII" );
	end
end

SOII["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

SOII["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "SOII";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

SOII["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		SOII["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

SOII["Lbl"].MouseUp = function( sender, args )
	SOII["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.SOIILocX = SOII["Ctr"]:GetLeft();
	settings.SigilOfImladIthil.X = string.format("%.0f", _G.SOIILocX);
	_G.SOIILocY = SOII["Ctr"]:GetTop();
	settings.SigilOfImladIthil.Y = string.format("%.0f", _G.SOIILocY);
	SaveSettings( false );
end
--**^

function MoveSOIICtr(sender, args)
	local CtrLocX = SOII["Ctr"]:GetLeft();
	local CtrWidth = SOII["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = SOII["Ctr"]:GetTop();
	local CtrHeight = SOII["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	SOII["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end