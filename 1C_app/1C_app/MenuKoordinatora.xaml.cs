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
using System.Windows.Shapes;

namespace _1C_app
{
    /// <summary>
    /// Логика взаимодействия для MenuKoordinatora.xaml
    /// </summary>
    public partial class MenuKoordinatora : Window
    {
        public MenuKoordinatora()
        {
            InitializeComponent();
        }
        private void BackMenu()
        {
            MainWindow MenuKoordinatora = new MainWindow();
            this.Close();
            MenuKoordinatora.ShowDialog();
        }
        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();
        }

        private void Button_Loguot_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();
        }

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
