using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace W10SS_GUI.Controls
{
    /// <summary>
    /// Логика взаимодействия для ToggleSwitch.xaml
    /// </summary>
    public partial class ToggleSwitch : UserControl
    {
        private Brush brushBackground { get; set; } = Application.Current.TryFindResource("colorToggleBackground") as Brush;
        private Brush brushBackgroundHover { get; set; } = Application.Current.TryFindResource("colorToggleBackgroundHover") as Brush;

        public ToggleSwitch()
        {
            InitializeComponent();
        }

        public bool IsChecked
        {
            get { return (bool)GetValue(IsCheckedProperty); }
            set { SetValue(IsCheckedProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IsChecked.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IsCheckedProperty =
            DependencyProperty.Register("IsChecked", typeof(bool), typeof(ToggleSwitch), new PropertyMetadata(default(bool)));        

        public string Header
        {
            get { return (string)GetValue(HeaderProperty); }
            set { SetValue(HeaderProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Header.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty HeaderProperty =
            DependencyProperty.Register("Header", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));

        public string Description
        {
            get { return (string)GetValue(DescriptionProperty); }
            set { SetValue(DescriptionProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Description.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty DescriptionProperty =
            DependencyProperty.Register("Description", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));

        public bool IsValid
        {
            get { return (bool)GetValue(IsValidProperty); }
            set { SetValue(IsValidProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IsValid.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IsValidProperty =
            DependencyProperty.Register("IsValid", typeof(bool), typeof(ToggleSwitch), new PropertyMetadata(default(bool)));


        public string ScriptPath
        {
            get { return (string)GetValue(ScriptPathProperty); }
            set { SetValue(ScriptPathProperty, value); }
        }

        // Using a DependencyProperty as the backing store for ScriptPath.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ScriptPathProperty =
            DependencyProperty.Register("ScriptPath", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));



        public string HeaderRU
        {
            get { return (string)GetValue(HeaderRUProperty); }
            set { SetValue(HeaderRUProperty, value); }
        }

        // Using a DependencyProperty as the backing store for HeaderRU.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty HeaderRUProperty =
            DependencyProperty.Register("HeaderRU", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));

        public string HeaderEN
        {
            get { return (string)GetValue(HeaderENProperty); }
            set { SetValue(HeaderENProperty, value); }
        }

        // Using a DependencyProperty as the backing store for HeaderEN.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty HeaderENProperty =
            DependencyProperty.Register("HeaderEN", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));



        public string DescriptionRU
        {
            get { return (string)GetValue(DescriptionRUProperty); }
            set { SetValue(DescriptionRUProperty, value); }
        }

        // Using a DependencyProperty as the backing store for DescriptionRU.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty DescriptionRUProperty =
            DependencyProperty.Register("DescriptionRU", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));

        public string DescriptionEN
        {
            get { return (string)GetValue(DescriptionENProperty); }
            set { SetValue(DescriptionENProperty, value); }
        }

        // Using a DependencyProperty as the backing store for DescriptionEN.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty DescriptionENProperty =
            DependencyProperty.Register("DescriptionEN", typeof(string), typeof(ToggleSwitch), new PropertyMetadata(default(string)));

        public event RoutedEventHandler IsSwitched;

        private void ToggleSwitch_Click(object sender, RoutedEventArgs e)
        {
            gridToggleSwitch.Background = toggleSwitch.IsChecked == true ? brushBackgroundHover : brushBackground ;
            IsSwitched?.Invoke(this, new RoutedEventArgs());
        }

        private void GridToggleSwitch_MouseEnter(object sender, MouseEventArgs e)
        {
            if (toggleSwitch.IsChecked == false) gridToggleSwitch.Background = brushBackgroundHover;
        }

        private void GridToggleSwitch_MouseLeave(object sender, MouseEventArgs e)
        {
            if (toggleSwitch.IsChecked == false) gridToggleSwitch.Background = brushBackground;
        }
    }
}
