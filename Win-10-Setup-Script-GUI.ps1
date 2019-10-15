Add-Type -AssemblyName "PresentationCore", "PresentationFramework", "WindowsBase"

[xml]$xamlMarkup = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"                        
        Name="Window"
        Title="Windows 10 Setup Script" Height="850" Width="1120" MinHeight="850" MinWidth="1120"
        Background="#F1F1F1"        
        FontFamily="Sergio UI" FontSize="16" TextOptions.TextFormattingMode="Display" WindowStartupLocation="CenterScreen"
        SnapsToDevicePixels="True" WindowStyle="None" ResizeMode="CanResizeWithGrip" AllowsTransparency="True" 
        ShowInTaskbar="True" Foreground="#000000">
    <Window.Resources>

        <!--#region Brushes -->

        <SolidColorBrush x:Key="RadioButton.Static.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Static.Border" Color="#FF333333"/>
        <SolidColorBrush x:Key="RadioButton.Static.Glyph" Color="#FF333333"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Border" Color="#FF000000"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Glyph" Color="#FF000000"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Background" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Border" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Glyph" Color="#FF999999"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.On.Background" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Border" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Glyph" Color="#FFA3A3A3"/>

        <SolidColorBrush x:Key="RadioButton.Pressed.Background" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Checked.Background" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Border" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Glyph" Color="#FFFFFFFF"/>

        <!--#endregion-->

        <Style x:Key="TitlePanelCloseHover" TargetType="StackPanel">
            <Setter Property="Orientation" Value="Horizontal"/>
            <Setter Property="Height" Value="35"/>
            <Setter Property="Width" Value="35"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#FF1744"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="TitlePanelHover" TargetType="StackPanel" BasedOn="{StaticResource TitlePanelCloseHover}">
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#E6E6E6"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="TitleButtonViewBox" TargetType="Viewbox">
            <Setter Property="Width" Value="24"/>
            <Setter Property="Height" Value="24"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="5 0 0 0"/>
        </Style>

        <Style x:Key="ActionButtonViewBox" TargetType="Viewbox" BasedOn="{StaticResource TitleButtonViewBox}">
            <Setter Property="Margin" Value="10 0 0 0"/>
        </Style>

        <Style x:Key="ActionButtonPanel" TargetType="StackPanel">            
            <Setter Property="Orientation" Value="Horizontal"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="0 0 0 7"/>            
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#D8D8D8"/>
                </Trigger>
                <EventTrigger RoutedEvent="MouseDown">
                    <EventTrigger.Actions>
                        <BeginStoryboard>
                            <Storyboard>
                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:0.5" From="0 0 0 7" To="0 5 0 0" SpeedRatio="5" AutoReverse="True"/>                                
                            </Storyboard>
                        </BeginStoryboard>
                    </EventTrigger.Actions>
                </EventTrigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="ActionButtonTextBlock" TargetType="TextBlock">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="10 2 20 0"/>
        </Style>

        <Style x:Key="PlaceholderPanel" TargetType="StackPanel">
            <Setter Property="Grid.Column" Value="0"/>
            <Setter Property="Orientation" Value="Horizontal"/>
            <Setter Property="Height" Value="14"/>
            
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
        </Style>

        <Style x:Key="PlaceholderBorder" TargetType="Border">
            <Setter Property="BorderThickness" Value="0 1 0 0"/>
            <Setter Property="BorderBrush" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Width" Value="225"/>
        </Style>

        <Style x:Key="ToggleSwitchLeftStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="10 0 10 0" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="{StaticResource RadioButton.Static.Background}"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="{StaticResource RadioButton.MouseOver.Background}"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ToggleSwitchScrollViewer" TargetType="ScrollViewer">
            <Setter Property="Grid.Column" Value="1"/>
            <Setter Property="Margin" Value="0 44 0 0"/>
            <Setter Property="HorizontalScrollBarVisibility" Value="Auto"/>
            <Setter Property="VerticalScrollBarVisibility" Value="Auto"/>
        </Style>

        <Style x:Key="TogglePanelShadowEffect" TargetType="StackPanel">
            <Setter Property="Orientation" Value="Vertical"/>
            <Setter Property="Effect">
                <Setter.Value>
                    <DropShadowEffect ShadowDepth="2" Direction="315" BlurRadius="3" Opacity="0.5"/>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ToggleHeaderTextBlock" TargetType="TextBlock">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="16 0 0 0"/>
            <Setter Property="FontSize" Value="18"/>
            <Setter Property="FontWeight" Value="Bold"/>
        </Style>

        <Style x:Key="ToggleBorder" TargetType="Border">
            <Setter Property="BorderBrush" Value="#DADADA"/>
            <Setter Property="BorderThickness" Value="1 1 1 0"/>
            <Setter Property="Margin" Value="0 0 20 0"/>
            <Setter Property="Background" Value="#FFFFFF"/>
        </Style>

        <Style x:Key="ToggleHeaderBorder" TargetType="Border" BasedOn="{StaticResource ToggleBorder}">
            <Setter Property="Height" Value="40"/>
        </Style>

    </Window.Resources>

    <Border Name="BorderWindow" BorderThickness="1" BorderBrush="#0078d7">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="240"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!--#region Window Title-->
            <StackPanel Name="WindowTitleLogo" Grid.Column="0" Orientation="Horizontal" Height="40" VerticalAlignment="Top">
                <!--Icon-->
                <Viewbox Width="28" Height="28" HorizontalAlignment="Left" Margin="10 0 5 0">
                    <Canvas Width="24" Height="24">
                        <Path Data="M3,12V6.75L9,5.43V11.91L3,12M20,3V11.75L10,11.9V5.21L20,3M3,13L9,13.09V19.9L3,18.75V13M20,13.25V22L10,20.09V13.1L20,13.25Z" Fill="{Binding ElementName=Window,Path=Foreground}" />
                    </Canvas>
                </Viewbox>
                <!--Title Text-->
                <TextBlock Text="{Binding ElementName=Window, Path=Title}" Foreground="{Binding ElementName=Window, Path=Foreground}" VerticalAlignment="Center" Margin="0 5 0 0"/>
            </StackPanel>
            <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Top" HorizontalAlignment="Right" Panel.ZIndex="10">
                <!--Minimize Button-->
                <StackPanel Name="ButtonTitleMin" Style="{StaticResource TitlePanelHover}">
                    <Viewbox Style="{StaticResource TitleButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M20,14H4V10H20" Fill="{Binding ElementName=Window,Path=Foreground}" />
                        </Canvas>
                    </Viewbox>
                </StackPanel>
                <!--Maximize Button-->
                <StackPanel Name="ButtonTitleMax" Style="{StaticResource TitlePanelHover}">
                    <Viewbox Style="{StaticResource TitleButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M4,4H20V20H4V4M6,8V18H18V8H6Z" Fill="{Binding ElementName=Window,Path=Foreground}" />
                        </Canvas>
                    </Viewbox>
                </StackPanel>
                <!--Close Button-->
                <StackPanel Name="ButtonTitleClose" Style="{StaticResource TitlePanelCloseHover}">
                    <Viewbox Style="{StaticResource TitleButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z" Fill="{Binding ElementName=Window,Path=Foreground}" />
                        </Canvas>
                    </Viewbox>
                </StackPanel>
            </StackPanel>

            <!--#endregion Window Title Panel-->

            <!--#region Action Buttons-->
            <StackPanel Name="PanelActionButtons" Orientation="Vertical" VerticalAlignment="Center" Margin="0 20 0 0">

                <!--#region Privacy Button-->
                <StackPanel Name="PanelActionPrivacy" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Name="IconActionPrivacy" Data="M18.15,4.94C17.77,4.91 17.37,5 17,5.2L8.35,10.2C7.39,10.76 7.07,12 7.62,12.94L9.12,15.53C9.67,16.5 10.89,16.82 11.85,16.27L13.65,15.23C13.92,15.69 14.32,16.06 14.81,16.27V18.04C14.81,19.13 15.7,20 16.81,20H22V18.04H16.81V16.27C17.72,15.87 18.31,14.97 18.31,14C18.31,13.54 18.19,13.11 17.97,12.73L20.5,11.27C21.47,10.71 21.8,9.5 21.24,8.53L19.74,5.94C19.4,5.34 18.79,5 18.15,4.94M6.22,13.17L2,13.87L2.75,15.17L4.75,18.63L5.5,19.93L8.22,16.63L6.22,13.17Z" Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionPrivacy" Text="Privacy &amp; Telemetry" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Privacy Button-->

                <!--#region UI & Personalization Button-->
                <StackPanel Name="PanelActionUi" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M4 4C2.89 4 2 4.89 2 6V18C2 19.11 2.9 20 4 20H12V18H4V8H20V12H22V8C22 6.89 21.1 6 20 6H12L10 4M18 14C17.87 14 17.76 14.09 17.74 14.21L17.55 15.53C17.25 15.66 16.96 15.82 16.7 16L15.46 15.5C15.35 15.5 15.22 15.5 15.15 15.63L14.15 17.36C14.09 17.47 14.11 17.6 14.21 17.68L15.27 18.5C15.25 18.67 15.24 18.83 15.24 19C15.24 19.17 15.25 19.33 15.27 19.5L14.21 20.32C14.12 20.4 14.09 20.53 14.15 20.64L15.15 22.37C15.21 22.5 15.34 22.5 15.46 22.5L16.7 22C16.96 22.18 17.24 22.35 17.55 22.47L17.74 23.79C17.76 23.91 17.86 24 18 24H20C20.11 24 20.22 23.91 20.24 23.79L20.43 22.47C20.73 22.34 21 22.18 21.27 22L22.5 22.5C22.63 22.5 22.76 22.5 22.83 22.37L23.83 20.64C23.89 20.53 23.86 20.4 23.77 20.32L22.7 19.5C22.72 19.33 22.74 19.17 22.74 19C22.74 18.83 22.73 18.67 22.7 18.5L23.76 17.68C23.85 17.6 23.88 17.47 23.82 17.36L22.82 15.63C22.76 15.5 22.63 15.5 22.5 15.5L21.27 16C21 15.82 20.73 15.65 20.42 15.53L20.23 14.21C20.22 14.09 20.11 14 20 14M19 17.5C19.83 17.5 20.5 18.17 20.5 19C20.5 19.83 19.83 20.5 19 20.5C18.16 20.5 17.5 19.83 17.5 19C17.5 18.17 18.17 17.5 19 17.5Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionUi" Text="UI &amp; Personalization" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion UI & Personalization Button-->

                <!--#region OneDrive Button-->
                <StackPanel Name="PanelActionOneDrive" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M20.08,13.64C21.17,13.81 22,14.75 22,15.89C22,16.78 21.5,17.55 20.75,17.92L20.58,18H9.18L9.16,18V18C7.71,18 6.54,16.81 6.54,15.36C6.54,13.9 7.72,12.72 9.18,12.72L9.4,12.73L9.39,12.53A3.3,3.3 0 0,1 12.69,9.23C13.97,9.23 15.08,9.96 15.63,11C16.08,10.73 16.62,10.55 17.21,10.55A2.88,2.88 0 0,1 20.09,13.43L20.08,13.64M8.82,12.16C7.21,12.34 5.96,13.7 5.96,15.36C5.96,16.04 6.17,16.66 6.5,17.18H4.73A2.73,2.73 0 0,1 2,14.45C2,13 3.12,11.83 4.53,11.73L4.46,11.06C4.46,9.36 5.84,8 7.54,8C8.17,8 8.77,8.18 9.26,8.5C9.95,7.11 11.4,6.15 13.07,6.15C15.27,6.15 17.08,7.83 17.3,9.97H17.21C16.73,9.97 16.27,10.07 15.84,10.25C15.12,9.25 13.96,8.64 12.69,8.64C10.67,8.64 9,10.19 8.82,12.16Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionOneDrive" Text="OneDrive" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion OneDrive Button-->

                <!--#region System Button-->
                <StackPanel Name="PanelActionSystem" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,15.5A3.5,3.5 0 0,1 8.5,12A3.5,3.5 0 0,1 12,8.5A3.5,3.5 0 0,1 15.5,12A3.5,3.5 0 0,1 12,15.5M19.43,12.97C19.47,12.65 19.5,12.33 19.5,12C19.5,11.67 19.47,11.34 19.43,11L21.54,9.37C21.73,9.22 21.78,8.95 21.66,8.73L19.66,5.27C19.54,5.05 19.27,4.96 19.05,5.05L16.56,6.05C16.04,5.66 15.5,5.32 14.87,5.07L14.5,2.42C14.46,2.18 14.25,2 14,2H10C9.75,2 9.54,2.18 9.5,2.42L9.13,5.07C8.5,5.32 7.96,5.66 7.44,6.05L4.95,5.05C4.73,4.96 4.46,5.05 4.34,5.27L2.34,8.73C2.21,8.95 2.27,9.22 2.46,9.37L4.57,11C4.53,11.34 4.5,11.67 4.5,12C4.5,12.33 4.53,12.65 4.57,12.97L2.46,14.63C2.27,14.78 2.21,15.05 2.34,15.27L4.34,18.73C4.46,18.95 4.73,19.03 4.95,18.95L7.44,17.94C7.96,18.34 8.5,18.68 9.13,18.93L9.5,21.58C9.54,21.82 9.75,22 10,22H14C14.25,22 14.46,21.82 14.5,21.58L14.87,18.93C15.5,18.67 16.04,18.34 16.56,17.94L19.05,18.95C19.27,19.03 19.54,18.95 19.66,18.73L21.66,15.27C21.78,15.05 21.73,14.78 21.54,14.63L19.43,12.97Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionSystem" Text="System" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion System Button-->

                <!--#region Start Menu Button-->
                <StackPanel Name="PanelActionStartMenu" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,12V6.75L9,5.43V11.91L3,12M20,3V11.75L10,11.9V5.21L20,3M3,13L9,13.09V19.9L3,18.75V13M20,13.25V22L10,20.09V13.1L20,13.25Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionStartMenu" Text="Start Menu" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Start Menu Button-->

                <!--#region Edge Button-->
                <StackPanel Name="PanelActionEdge" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M2.74,10.81C3.83,-1.36 22.5,-1.36 21.2,13.56H8.61C8.61,17.85 14.42,19.21 19.54,16.31V20.53C13.25,23.88 5,21.43 5,14.09C5,8.58 9.97,6.81 9.97,6.81C9.97,6.81 8.58,8.58 8.54,10.05H15.7C15.7,2.93 5.9,5.57 2.74,10.81Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionEdge" Text="Microsoft Edge" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Edge Button-->

                <!--#region Uwp Button-->
                <StackPanel Name="PanelActionUwp" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M10.31 10.93C11.33 12.57 11.18 14.5 9.96 15.28C8.74 16.04 6.92 15.33 5.89 13.69C4.87 12.05 5.03 10.1 6.25 9.34C7.47 8.58 9.29 9.29 10.31 10.93M12 17.75C14 17.75 14.5 17 14.5 17C14.5 17 14 19 12 19C10 19 9.5 17.03 9.5 17C9.5 17 10 17.75 12 17.75M17.75 9.34C18.97 10.1 19.13 12.05 18.11 13.69C17.08 15.33 15.26 16.04 14.04 15.28C12.82 14.5 12.67 12.57 13.69 10.93C14.71 9.29 16.53 8.58 17.75 9.34M12 20C14.5 20 20 14.86 20 11C20 7.14 16.41 4 12 4C7.59 4 4 7.14 4 11C4 14.86 9.5 20 12 20M12 2C17.5 2 22 6.04 22 11C22 15.08 16.32 22 12 22C7.68 22 2 15.08 2 11C2 6.04 6.5 2 12 2Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionUwp" Text="UWP Apps" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Uwp Button-->

                <!--#region Game Button-->
                <StackPanel Name="PanelActionGame" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M6.43,3.72C6.5,3.66 6.57,3.6 6.62,3.56C8.18,2.55 10,2 12,2C13.88,2 15.64,2.5 17.14,3.42C17.25,3.5 17.54,3.69 17.7,3.88C16.25,2.28 12,5.7 12,5.7C10.5,4.57 9.17,3.8 8.16,3.5C7.31,3.29 6.73,3.5 6.46,3.7M19.34,5.21C19.29,5.16 19.24,5.11 19.2,5.06C18.84,4.66 18.38,4.56 18,4.59C17.61,4.71 15.9,5.32 13.8,7.31C13.8,7.31 16.17,9.61 17.62,11.96C19.07,14.31 19.93,16.16 19.4,18.73C21,16.95 22,14.59 22,12C22,9.38 21,7 19.34,5.21M15.73,12.96C15.08,12.24 14.13,11.21 12.86,9.95C12.59,9.68 12.3,9.4 12,9.1C12,9.1 11.53,9.56 10.93,10.17C10.16,10.94 9.17,11.95 8.61,12.54C7.63,13.59 4.81,16.89 4.65,18.74C4.65,18.74 4,17.28 5.4,13.89C6.3,11.68 9,8.36 10.15,7.28C10.15,7.28 9.12,6.14 7.82,5.35L7.77,5.32C7.14,4.95 6.46,4.66 5.8,4.62C5.13,4.67 4.71,5.16 4.71,5.16C3.03,6.95 2,9.35 2,12A10,10 0 0,0 12,22C14.93,22 17.57,20.74 19.4,18.73C19.4,18.73 19.19,17.4 17.84,15.5C17.53,15.07 16.37,13.69 15.73,12.96Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionGame" Text="Windows Game Recording" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Game Button-->

                <!--#region Scheduled Tasks Button-->
                <StackPanel Name="PanelActionTasks" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M19,19H5V8H19M19,3H18V1H16V3H8V1H6V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5A2,2 0 0,0 19,3M16.53,11.06L15.47,10L10.59,14.88L8.47,12.76L7.41,13.82L10.59,17L16.53,11.06Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionTasks" Text="Scheduled Tasks" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Scheduled Tasks Button-->

                <!--#region Microsoft Defender Button-->
                <StackPanel Name="PanelActionDefender" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M21,11C21,16.55 17.16,21.74 12,23C6.84,21.74 3,16.55 3,11V5L12,1L21,5V11M12,21C15.75,20 19,15.54 19,11.22V6.3L12,3.18V21Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionDefender" Text="Microsoft Defender" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Microsoft Defender Button-->

                <!--#region Context Menu Button-->
                <StackPanel Name="PanelActionMenu" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,3H9V7H3V3M15,10H21V14H15V10M15,17H21V21H15V17M13,13H7V18H13V20H7L5,20V9H7V11H13V13Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionMenu" Text="Context Menu" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Microsoft Defender Button-->
                
                <!--#region Placeholder-->
                <StackPanel Style="{StaticResource PlaceholderPanel}">
                    <Border Style="{StaticResource PlaceholderBorder}"/>
                </StackPanel>
                <!--#endregion Placeholder-->               

                <!--#region Save Button-->
                <StackPanel Name="PanelButtonSave" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,2A3,3 0 0,0 9,5C9,6.27 9.8,7.4 11,7.83V10H8V12H11V18.92C9.16,18.63 7.53,17.57 6.53,16H8V14H3V19H5V17.3C6.58,19.61 9.2,21 12,21C14.8,21 17.42,19.61 19,17.31V19H21V14H16V16H17.46C16.46,17.56 14.83,18.63 13,18.92V12H16V10H13V7.82C14.2,7.4 15,6.27 15,5A3,3 0 0,0 12,2M12,4A1,1 0 0,1 13,5A1,1 0 0,1 12,6A1,1 0 0,1 11,5A1,1 0 0,1 12,4Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionSave" Text="Save Settings" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Github Button-->

                <!--#region Load Button-->
                <StackPanel Name="PanelButtonLoad" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M7.5,5.6L5,7L6.4,4.5L5,2L7.5,3.4L10,2L8.6,4.5L10,7L7.5,5.6M19.5,15.4L22,14L20.6,16.5L22,19L19.5,17.6L17,19L18.4,16.5L17,14L19.5,15.4M22,2L20.6,4.5L22,7L19.5,5.6L17,7L18.4,4.5L17,2L19.5,3.4L22,2M13.34,12.78L15.78,10.34L13.66,8.22L11.22,10.66L13.34,12.78M14.37,7.29L16.71,9.63C17.1,10 17.1,10.65 16.71,11.04L5.04,22.71C4.65,23.1 4,23.1 3.63,22.71L1.29,20.37C0.9,20 0.9,19.35 1.29,18.96L12.96,7.29C13.35,6.9 14,6.9 14.37,7.29Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionLoad" Text="Load Settings" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Github Button-->

                <!--#region Apply Button-->
                <StackPanel Name="PanelButtonApply" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionApply" Text="Apply Settings" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Apply Button-->

                <!--#region Placeholder-->
                <StackPanel Style="{StaticResource PlaceholderPanel}">
                    <Border Style="{StaticResource PlaceholderBorder}"/>
                </StackPanel>
                <!--#endregion Placeholder-->

                <!--#region Github Button-->
                <StackPanel Name="PanelButtonGithub" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionGithub" Text="Follow on GitHub" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Github Button-->

                <!--#region Language Button-->
                <StackPanel Name="PanelButtonLanguage" Style="{StaticResource ActionButtonPanel}">
                    <Viewbox Style="{StaticResource ActionButtonViewBox}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M16.36,14C16.44,13.34 16.5,12.68 16.5,12C16.5,11.32 16.44,10.66 16.36,10H19.74C19.9,10.64 20,11.31 20,12C20,12.69 19.9,13.36 19.74,14M14.59,19.56C15.19,18.45 15.65,17.25 15.97,16H18.92C17.96,17.65 16.43,18.93 14.59,19.56M14.34,14H9.66C9.56,13.34 9.5,12.68 9.5,12C9.5,11.32 9.56,10.65 9.66,10H14.34C14.43,10.65 14.5,11.32 14.5,12C14.5,12.68 14.43,13.34 14.34,14M12,19.96C11.17,18.76 10.5,17.43 10.09,16H13.91C13.5,17.43 12.83,18.76 12,19.96M8,8H5.08C6.03,6.34 7.57,5.06 9.4,4.44C8.8,5.55 8.35,6.75 8,8M5.08,16H8C8.35,17.25 8.8,18.45 9.4,19.56C7.57,18.93 6.03,17.65 5.08,16M4.26,14C4.1,13.36 4,12.69 4,12C4,11.31 4.1,10.64 4.26,10H7.64C7.56,10.66 7.5,11.32 7.5,12C7.5,12.68 7.56,13.34 7.64,14M12,4.03C12.83,5.23 13.5,6.57 13.91,8H10.09C10.5,6.57 11.17,5.23 12,4.03M18.92,8H15.97C15.65,6.75 15.19,5.55 14.59,4.44C16.43,5.07 17.96,6.34 18.92,8M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2Z" Fill="{Binding ElementName=IconActionPrivacy, Path=Fill}" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="TextBlockActionLanguage" Text="Change Language" Style="{StaticResource ActionButtonTextBlock}"/>
                </StackPanel>
                <!--#endregion Github Button-->

            </StackPanel>
            <!--#endregion Action Button-->

            <!--#region Toggle Buttons-->
            <ScrollViewer Name="ScrollToggle" Style="{StaticResource ToggleSwitchScrollViewer}">
                
                <StackPanel Orientation="Vertical">

                    <!--#region Privacy & Telemetry-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderPrivacy" Text="Privacy &amp; Telemetry" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_0" Text="Turn off &quot;Connected User Experiences and Telemetry&quot; service" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_1" Text="Turn off per-user services" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_2" Text="Turn off the Autologger session at the next computer restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_3" Text="Turn off the SQMLogger session at the next computer restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_4" Text="Set the operating system diagnostic data level to &quot;Basic&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_4, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_4, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_5" Text="Turn off Windows Error Reporting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_5, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_5, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_6" Text="Change Windows Feedback frequency to &quot;Never&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_6, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_6, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_7" Text="Turn off diagnostics tracking scheduled tasks" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_7, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_7, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_8" Text="Do not offer tailored experiences based on the diagnostic data setting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_8, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_8, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_9" Text="Do not let apps on other devices open and message apps on this device, and vice versa" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_9, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_9, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_10" Text="Do not allow apps to use advertising ID" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_10, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_10, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_11" Text="Do not use sign-in info to automatically finish setting up device after an update or restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_11, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_11, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_12" Text="Do not let websites provide locally relevant content by accessing language list" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_12, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_12, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_13" Text="Turn on tip, trick, and suggestions as you use Windows" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_13, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_13, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_14" Text="Turn off app suggestions on Start menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_14, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_14, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_15" Text="Turn off suggested content in the Settings" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_15, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_15, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_16" Text="Turn off automatic installing suggested apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_16, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_16, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Privacy_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Privacy_17" Text="Turn off app launch tracking to improve Start menu and search results" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_17, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_17, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Privacy & Telemetry-->

                    <!--#region UI & Personalization-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderUI" Text="UI &amp; Personalization" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_0" Text="Set File Explorer to open to This PC by default" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_1" Text="Show Hidden Files, Folders, and Drives" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_2" Text="Show File Name Extensions" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_3" Text="Hide Task View button on taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_4" Text="Show folder merge conflicts" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_4, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_4, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_5" Text="Turn off Snap Assist" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_5, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_5, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_6" Text="Turn off check boxes to select items" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_6, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_6, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_7" Text="Show seconds on taskbar clock" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_7, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_7, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_8" Text="Hide People button on the taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_8, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_8, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_9" Text="Hide all folders in the navigation pane" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_9, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_9, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_10" Text="Remove 3D Objects folder in &quot;This PC&quot; and in the navigation pane" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_10, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_10, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_11" Text="Hide &quot;Frequent folders&quot; in Quick access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_11, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_11, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_12" Text="Hide &quot;Recent files&quot; in Quick access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_12, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_12, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_13" Text="Turn on acrylic taskbar transparency" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_13, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_13, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_14" Text="Show &quot;This PC&quot; on Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_14, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_14, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_15" Text="Show more details in file transfer dialog" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_15, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_15, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_16" Text="Remove the &quot;Previous Versions&quot; tab from properties context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_16, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_16, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_17" Text="Always show all icons in the notification area" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_17, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_17, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_18" Text="Set the Control Panel view by large icons" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_18, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_18, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_19" Text="Hide &quot;Windows Ink Workspace&quot; button in taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_19, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_19, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_20" Text="Hide search box or search icon on taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_20, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_20, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_21" Text="Turn on recycle bin files delete confirmation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_21, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_21, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_22" Text="Turn on ribbon in File Explorer" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_22, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_22, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_23" Text="Choose theme color for default Windows mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_23, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_23, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_24" Text="Choose theme color for default app mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_24, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_24, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_25" Text="Turn off &quot;New App Installed&quot; notification" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_25, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_25, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_26" Text="Turn off recently added apps on Start menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_26, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_26, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_27" Text="Turn off user first sign-in animation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_27, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_27, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_28" Text="Turn off JPEG desktop wallpaper import quality reduction" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_28, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_28, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_29" Text="Show Task Manager details" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_29, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_29, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_30" Text="Unpin Microsoft Edge and Microsoft Store from taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_30, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_30, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_31" Text="Remove Microsoft Edge shortcut from the Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_31, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_31, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_32" Text="Show accent color on the title bars and window borders" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_32, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_32, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_33" Text="Turn off automatically hiding scroll bars" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_33, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_33, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_34" Text="Save screenshots by pressing Win+PrtScr to the Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_34, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_34, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_35" Text="Show more Windows Update restart notifications about restarting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_35, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_35, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_36" Text="Turn off the &quot;- Shortcut&quot; name extension for new shortcuts" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_36, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_36, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_37" Text="Use the PrtScn button to open screen snipping" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_37, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_37, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UI_38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UI_38" Text="Automatically adjust active hours for me based on daily usage" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_38, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_38, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion UI & Personalization-->

                    <!--#region OneDrive-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderOneDrive" Text="OneDrive" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_OneDrive_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_OneDrive_0" Text="Uninstall OneDrive" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_OneDrive_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_OneDrive_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion OneDrive-->

                    <!--#region System-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderSystem" Text="System" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_0" Text="Turn on Storage Sense to automatically free up space" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_1" Text="Run Storage Sense every month" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_2" Text="Delete temporary files that apps aren't using" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_3" Text="Delete files in recycle bin if they have been there for over 30 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_4" Text="Never delete files in &quot;Downloads&quot; folder" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_4, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_4, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_5" Text="Let Windows try to fix apps so they're not blurry" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_5, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_5, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_6" Text="Turn off hibernate" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_6, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_6, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_7" Text="Turn off location for this device" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_7, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_7, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_8" Text="Change environment variable for $env:TEMP to $env:SystemDrive\Temp" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_8, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_8, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_9" Text="Remove &quot;$env:LOCALAPPDATA\Temp&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_9, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_9, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_10" Text="Remove &quot;$env:SYSTEMROOT\Temp&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_10, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_10, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_11" Text="Turn on Win32 long paths" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_11, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_11, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_12" Text="Group svchost.exe processes" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_12, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_12, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_13" Text="Turn on Retpoline patch against Spectre v2" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_13, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_13, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_14" Text="Turn on the display of stop error information on the BSoD" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_14, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_14, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_15" Text="Do not preserve zone information" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_15, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_15, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_16" Text="Turn off Admin Approval Mode for administrators" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_16, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_16, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_17" Text="Turn on access to mapped drives from app running with elevated permissions with&#x0a;Admin Approval Mode enabled" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_17, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_17, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_18" Text="Set download mode for delivery optization on &quot;HTTP only&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_18, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_18, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_19" Text="Always wait for the network at computer startup and logon" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_19, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_19, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_20" Text="Turn off Cortana" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_20, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_20, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_21" Text="Do not allow Windows 10 to manage default printer" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_21, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_21, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_22" Text="Turn off Windows features" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_22, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_22, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_23" Text="Remove Windows capabilities" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_23, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_23, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_24" Text="Turn on updates for other Microsoft products" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_24, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_24, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_25" Text="Enable System Restore" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_25, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_25, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_26" Text="Turn off Windows Script Host" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_26, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_26, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_27" Text="Turn off default background apps except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_27, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_27, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_28" Text="Set power management scheme for desktop and laptop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_28, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_28, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_29" Text="Turn on .NET 4 runtime for all apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_29, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_29, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_30" Text="Turn on firewall &amp; network protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_30, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_30, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_31" Text="Do not allow the computer to turn off the device to save power for desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_31, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_31, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_32" Text="Set the default input method to the English language" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_32, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_32, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_33" Text="Turn on Windows Sandbox" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_33, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_33, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_34" Text="Set location of the &quot;Desktop&quot;, &quot;Documents&quot;, &quot;Downloads&quot;, &quot;Music&quot;, &quot;Pictures&quot; and &quot;Videos&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_34, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_34, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_35" Text="Turn on automatic recommended troubleshooting and tell when problems get fixed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_35, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_35, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_36" Text="Set &quot;High performance&quot; in graphics performance preference for apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_36, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_36, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_37" Text="Launch folder in a separate process" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_37, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_37, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_38" Text="Turn off and delete reserved storage after the next update installation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_38, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_38, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_39" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_39" Text="Turn on automatic backup the system registry to the&#x0a;&quot;$env:SystemRoot\System32\config\RegBack&quot; folder" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_39, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_39, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_40" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_40" Text="Turn off &quot;The Windows Filtering Platform has blocked a connection&quot; message" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_40, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_40, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_41" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_41" Text="Turn off SmartScreen for apps and files" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_41, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_41, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_42" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_42" Text="Turn off F1 Help key" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_42, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_42, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_43" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_43" Text="Turn on Num Lock at startup" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_43, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_43, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_44" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_44" Text="Turn off sticky Shift key after pressing 5 times" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_44, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_44, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_45" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_45" Text="Turn off AutoPlay for all media and devices" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_45, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_45, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_46" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_46" Text="Turn off creation of an Edge shortcut on the desktop for each user profile" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_46, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_46, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_47" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_47" Text="Turn off thumbnail cache removal" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_47, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_47, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_System_48" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_System_48" Text="Turn On automatically save my restartable apps when sign out and restart them after sign in" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_48, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_48, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion System-->

                    <!--#region Start Menu-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderStartMenu" Text="Start Menu" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_StartMenu_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_StartMenu_0" Text="Open shortcut to the Command Prompt from Start menu as Administrator" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_StartMenu_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_StartMenu_1" Text="Create old style shortcut for &quot;Devices and Printers&quot; in&#x0a;&quot;$env:APPDATA\Microsoft\Windows\Start menu\Programs\System Tools&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_StartMenu_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_StartMenu_2" Text="Import Start menu layout from pre-saved reg file" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Start Menu-->

                    <!--#region Microsoft Edge-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderEdge" Text="Edge" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Edge_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Edge_0" Text="Turn off Windows Defender SmartScreen for Microsoft Edge" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Edge_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Edge_1" Text="Do not allow Microsoft Edge to start and load the Start and New Tab page&#x0a;at Windows startup and each time Microsoft Edge is closed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_Edge_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_Edge_2" Text="Do not allow Microsoft Edge to pre-launch at Windows startup, when the system is idle,&#x0a;and each time Microsoft Edge is closed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Microsoft Edge-->

                    <!--#region UWP Apps-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderUWPApps" Text="UWP Apps" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UWPApps_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UWPApps_0" Text="Uninstall all UWP apps from all accounts except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_UWPApps_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_UWPApps_1" Text="Uninstall all provisioned UWP apps from all accounts except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion UWP Apps-->

                    <!--#region Windows Game Recording-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderWindowsGameRecording" Text="Windows Game Recording" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_WindowsGameRecording_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_WindowsGameRecording_0" Text="Turn off Windows Game Recording and Broadcasting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_WindowsGameRecording_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_WindowsGameRecording_1" Text="Turn off Game Bar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_WindowsGameRecording_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_WindowsGameRecording_2" Text="Turn off Game Mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_WindowsGameRecording_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_WindowsGameRecording_3" Text="Turn off Game Bar tips" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Windows Game Recording-->

                    <!--#region Scheduled Tasks-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderScheduledTasks" Text="Scheduled Tasks" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ScheduledTasks_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ScheduledTasks_0" Text="Create a task in the Task Scheduler to start Windows cleaning up. The task runs every 90 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ScheduledTasks_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ScheduledTasks_1" Text="Create a task in the Task Scheduler to clear the &quot;$env:SystemRoot\SoftwareDistribution\Download&quot; folder.&#x0a;The task runs on Thursdays every 4 weeks" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ScheduledTasks_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ScheduledTasks_2" Text="Create a task in the Task Scheduler to clear the $env:TEMP folder. The task runs every 62 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Scheduled Tasks-->

                    <!--#region Microsoft Defender-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderMicrosoftDefender" Text="Microsoft Defender" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_0" Text="Add folder to exclude from Windows Defender Antivirus scan" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_1" Text="Turn on Controlled folder access and add protected folders" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_2" Text="Allow an app through Controlled folder access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_3" Text="Turn on Windows Defender Exploit Guard Network Protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_4" Text="Turn on Windows Defender PUA Protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_4, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_4, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_5" Text="Turn on Windows Defender Sandbox" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_5, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_5, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_6" Text="Hide notification about sign in with Microsoft in the Windows Security" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_6, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_6, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_MicrosoftDefender_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_MicrosoftDefender_7" Text="Hide notification about disabled Smartscreen for Microsoft Edge" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_7, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_7, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Microsoft Defender-->

                    <!--#region Context Menu-->
                    <Border Style="{StaticResource ToggleHeaderBorder}">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Name="HeaderContextMenu" Text="Context Menu" Style="{StaticResource ToggleHeaderTextBlock}"/>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_0" Text="Add &quot;Extract&quot; to MSI file type context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_0, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_0, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_1" Text="Add &quot;Run as different user&quot; from context menu for .exe file type" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_1, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_1, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_2" Text="Add &quot;Install&quot; to CAB file type context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_2, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_2, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_3" Text="Remove &quot;Cast to Device&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_3, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_3, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_4" Text="Remove &quot;Share&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_4, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_4, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_5" Text="Remove &quot;Previous Versions&quot; from file context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_5, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_5, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_6" Text="Remove &quot;Edit with Paint 3D&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_6, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_6, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_7" Text="Remove &quot;Include in Library&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_7, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_7, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_8" Text="Remove &quot;Turn on BitLocker&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_8, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_8, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_9" Text="Remove &quot;Edit with Photos&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_9, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_9, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_10" Text="Remove &quot;Create a new video&quot; from Context Menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_10, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_10, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_11" Text="Remove &quot;Edit&quot; from Context Menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_11, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_11, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_12" Text="Remove &quot;Print&quot; from batch and cmd files context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_12, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_12, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_13" Text="Remove &quot;Compressed (zipped) Folder&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_13, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_13, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_14" Text="Remove &quot;Rich Text Document&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_14, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_14, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_15" Text="Remove &quot;Bitmap image&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_15, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_15, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_16" Text="Remove &quot;Send to&quot; from folder context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_16, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_16, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_17" Text="Make the &quot;Open&quot;, &quot;Print&quot;, &quot;Edit&quot; context menu items available, when more than 15 selected" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_17, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_17, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <Border Style="{StaticResource ToggleBorder}">
                        <StackPanel Orientation="Horizontal" Margin="5">
                            <Grid HorizontalAlignment="Left">
                                <ToggleButton Name="ToggleSwitch_ContextMenu_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                <TextBlock Name="TextBlock_ContextMenu_18" Text="Turn off &quot;Look for an app in the Microsoft Store&quot; in &quot;Open with&quot; dialog" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                    <TextBlock.Style>
                                        <Style TargetType="{x:Type TextBlock}">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_18, Path=IsChecked}" Value="True">
                                                    <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                </DataTrigger>
                                                <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_18, Path=IsEnabled}" Value="false">
                                                    <Setter Property="Opacity" Value="0.2" />
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </Grid>
                        </StackPanel>
                    </Border>
                    <!--#endregion Context Menu-->

                    <!--#region Column Placeholder-->
                    <Border Height="{Binding ElementName=PanelActionPrivacy, Path=Height}" BorderBrush="#DADADA" BorderThickness="0 1 0 0" Margin="0 0 20 0"/>
                    <!--#endregion Column Placeholder-->

                </StackPanel>
            </ScrollViewer>
            <!--#endregion Toggle Buttons -->
        </Grid>
    </Border>
</Window>
'@

$xamlGui = [System.Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xamlMarkup))
$xamlMarkup.SelectNodes('//*[@Name]') | ForEach-Object {
    New-Variable -Name $_.Name -Value $xamlGui.FindName($_.Name)
        
}

#region Script Functions
function Hide-Console {
    <#
    .SYNOPSIS
    Hide Powershell console before show WPF GUI.    
    #>

    [CmdletBinding()]
    param ()

    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
}

function Set-Language {
    <#
    .SYNOPSIS
    Change Language in GUI.    
    #>

    [CmdletBinding()]
    param ()

    begin {
        #region Privacy
        $Privacy = "Отключить службу &quot;Функциональные возможности для подключенных пользователей и телеметрия&quot;", "Отключить пользовательские службы",
        "Отключить сборщик AutoLogger при следующем запуске ПК", "Отключить сборщик SQMLogger при следующем запуске ПК", "Установить уровень отправляемых диагностических сведений на &quot;Базовый&quot;",
        "Отключить отчеты об ошибках Windows для всех пользователей", "Изменить частоту формирования отзывов на &quot;Никогда&quot;", "Отключить задачи диагностического отслеживания",
        "Не предлагать персонализированныее возможности, основанные на выбранном параметре диагностических данных", "Не разрешать приложениям на других устройствах запускать приложения и отправлять сообщения на этом устройстве и наоборот", 
        "Не разрешать приложениям использовать идентификатор рекламы", "Не использовать данные для входа для автоматического завершения настройки устройства после перезапуска или обновления", 
        "Не позволять веб-сайтам предоставлять местную информацию за счет доступа к списку языков", "Показывать советы, подсказки и рекомендации при использованию Windows", "Не показывать рекомендации в меню &quot;Пуск&quot;", 
        "Не показывать рекомендуемое содержание в приложении &quot;Параметры&quot;", "Отключить автоматическую установку рекомендованных приложений", "Не разрешать Windows отслеживать запуски приложений для улучшения меню &quot;Пуск&quot; и результатов поиска и не показывать недавно добавленные приложения"
        #endregion Privacy

        #region UI
        $UI = "Открывать &quot;Этот компьютер&quot; в Проводнике", "Показывать скрытые файлы, папки и диски", "Показывать расширения для зарегистрированных типов файлов", "Не показывать кнопку Просмотра задач", 
        "Не скрывать конфликт слияния папок", "Не показывать при прикреплении окна, что можно прикрепить рядом с ним", "Отключить флажки для выбора элементов", "Включить отображение секунд в системных часах на панели задач", 
        "Не показывать панель &quot;Люди&quot; на панели задач", "Не отображать все папки в области навигации", "Скрыть папку &quot;Объемные объекты&quot; из &quot;Этот компьютер&quot; и на панели быстрого доступа", 
        "Не показывать недавно используемые папки на панели быстрого доступа", "Не показывать недавно использовавшиеся файлы на панели быстрого доступа", "Включить прозрачную панель задач", "Отобразить &quot;Этот компьютер&quot; на рабочем столе", 
        "Развернуть диалог переноса файлов", "Отключить отображение вкладки &quot;Предыдущие версии&quot; в свойствах файлов и папок", "Всегда отображать все значки в области уведомлений", "Установить крупные значки в панели управления", 
        "Скрыть кнопку Windows Ink Workspace на панели задач", "Скрыть поле или значок поиска на Панели задач", "Запрашивать подтверждение на удалении файлов из корзины", "Включить отображение ленты проводника в развернутом виде", 
        "Выбрать режим Windows по умолчанию", "Выбрать режим приложения по умолчанию", "Не показывать уведомление &quot;Установлено новое приложение&quot;", "Не показывать недавно добавленные приложения в меню &quot;Пуск&quot;", 
        "Не показывать анимацию при первом входе в систему", "Установка качества фона рабочего стола на 100 %", "Раскрыть окно Диспетчера задач", "Открепить Microsoft Edge и Microsoft Store от панели задач", 
        "Удалить ярлык Microsoft Edge с рабочего стола", "Отображать цвет элементов в заголовках окон и границ окон", "Отключить автоматическое скрытие полос прокрутки в Windows", "Сохранить скриншот по Win+PrtScr на рабочем столе", 
        "Показывать уведомление, когда компьютеру требуется перезагрузка для завершения обновления", "He дoбaвлять &quot;- яpлык&quot; для coздaвaeмыx яpлыкoв", "Использовать клавишу Print Screen, чтобы запустить функцию создания фрагмента экрана", 
        "Автоматически изменять период активности для этого устройства на основе действий"
        #endregion UI

        #region OneDrive
        $OneDrive = "Удалить OneDrive"
        #endregion OneDrive

    }

    process {

    }

    end {

    }
}

#endregion

#region Controls Events

$Window.add_MouseDown( {
        $Window.DragMove()
    })

$ButtonTitleMin.add_MouseDown( {
        $Window.WindowState = "Minimized"
    })

$ButtonTitleMax.add_MouseDown( {
        
        if ($Window.WindowState -eq "Normal") {
            $Window.WindowState = "Maximized"
        }

        else {
            $Window.WindowState = "Normal"            
        }

    })

$ButtonTitleClose.add_MouseDown( {
        $Window.Close()
    })

$PanelButtonLanguage.add_MouseDown({
    Set-Language
})

#endregion

Hide-Console
$Window.ShowDialog() | Out-Null