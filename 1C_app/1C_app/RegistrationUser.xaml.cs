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
    /// Логика взаимодействия для RegistrationUser.xaml
    /// </summary>
    public partial class RegistrationUser : Window
    {
        public RegistrationUser()
        {
            InitializeComponent();
        }
        private void BackMenu()
        {
            MainWindow RegistrationUser = new MainWindow();
            this.Close();
            RegistrationUser.ShowDialog();
        }
        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();   
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void Button_registr_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Otmena_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();
        }

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
