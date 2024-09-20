using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
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
    /// Логика взаимодействия для LoginApp.xaml
    /// </summary>
    public partial class LoginApp : Window
    {
        
        string connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=DSA;Trusted_Connection=True;";
        public LoginApp()
        {
            InitializeComponent();
        }
        public static class Global
        {
            public static string Login { get; set; }
            public static string Password { get; set; }
        }
        private void LoginUser()
        {
            string enteredPhoneNumber = Login_TextBox.Text;
            string enteredPassword = Password_Box.Password;

            Global.Login = enteredPhoneNumber;
            Global.Password = enteredPassword;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string sqlQuery = $"SELECT Password FROM [User] WHERE Email = '{Global.Login}'";
                    using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                    {
                        string hashedEnteredPassword = HashPassword(enteredPassword);
                        string hashedPasswordFromDB = (string)command.ExecuteScalar();

                        if (hashedPasswordFromDB != null && hashedPasswordFromDB.Equals(hashedEnteredPassword))
                        {
                            ChoiceUser LoginApp = new ChoiceUser();
                            this.Close();
                            LoginApp.ShowDialog();
                        }
                        else
                        {
                            MessageBox.Show("Неверная электронная почта или пароль");
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}");
                }
            }
        }
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hashedBytes.Length; i++)
                {
                    builder.Append(hashedBytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
        private void ClouseWindow()
        {
            MainWindow LoginApp = new MainWindow();
            this.Close();
            LoginApp.ShowDialog();
        }
        private void Button_Cancel_Click(object sender, RoutedEventArgs e)
        {
            ClouseWindow();
        }

        private void Button_Login_Click(object sender, RoutedEventArgs e)
        {
            LoginUser();
        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            ClouseWindow();
        }
    }
}
