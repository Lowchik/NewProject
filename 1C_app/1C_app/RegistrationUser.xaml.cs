using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
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
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using static _1C_app.LoginApp;

namespace _1C_app
{
    /// <summary>
    /// Логика взаимодействия для RegistrationUser.xaml
    /// </summary>
    public partial class RegistrationUser : Window
    {
        //string connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=DSA;Trusted_Connection=True;";
        string connectionString = "Server=.\\SQLEXPRESS;Database=DSA;Trusted_Connection=True;";
        public RegistrationUser()
        {
            InitializeComponent();
            LoadComboBoxData();
            LoadComboBoxGender();
        }
        private void LoadComboBoxData()
        {

            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            if (connection.State == ConnectionState.Open)
            {
                string sqlExpression1 = $"select CountryName from Country";
                SqlCommand command1 = new SqlCommand(sqlExpression1, connection);
                SqlDataReader reader1 = command1.ExecuteReader();
                if (reader1.HasRows)
                {
                    while (reader1.Read())
                    {
                        string fullName = $"{reader1.GetString(0)}";

                        Country_add_ComboBox.Items.Add(fullName);
                    }
                    reader1.Close();
                }

            }
            connection.Close();
        }
        private void LoadComboBoxGender()
        {
            Gender_add_ComboBox.ItemsSource = new List<string> { "Мужской", "Женский" };
        }
        public void DateT_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            string text = textBox.Text.Trim();


            text = Regex.Replace(text, @"\D", "");

            if (text.Length >= 3)
            {
                text = text.Insert(2, ".");

                if (text.Length > 5)
                {
                    text = text.Insert(5, ".");
                }
            }

            textBox.Text = text;
            textBox.CaretIndex = text.Length;
        }
        private bool CheckEmail(string email)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();

                string sqlQueryq = $"SELECT Email FROM [dbo].[user] WHERE Email = N'{email}' ";

                using (SqlCommand command = new SqlCommand(sqlQueryq, connection))

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }


            }
        }
        private bool IsValidAge(string birthDateString, int minimumAge)
        {
            DateTime birthDate;
            if (DateTime.TryParse(birthDateString, out birthDate))
            {
                int age = DateTime.Now.Year - birthDate.Year;
                if (birthDate > DateTime.Now.AddYears(-age)) age--; 
                return age >= minimumAge;
            }
            return false; 
        }

        private void RegistrRunner()
        {
            
            string sqlQueryy = "DECLARE @Emailll VARCHAR (50) = @Email;" +
                "Declare @country int = (Select [Country].CountryCode from Country where [Country].CountryName = @CountryName);" +
                "INSERT INTO [User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (@Emailll,@Password,@FirstName,@LastName,N'R')" +
                "INSERT INTO [Runner] ([RunnerId], [Email], [Gender], [DateOfBirth], [CountryCode]) VALUES ((SELECT ISNULL(MAX(RunnerId), 0) + 1 FROM [Runner]),@Emailll, @Gender, @DateOfBirth,@country)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();
                    SqlCommand command = new SqlCommand(sqlQueryy, connection);

                 
                    if (!Regex.IsMatch(Email_add.Text, @"^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"))
                    {
                    Email_add.Background = Brushes.DarkRed;
                    throw new Exception ("Введите коректно почту");
                    }
                    else
                    {
                        if (CheckEmail(Email_add.Text))
                        {
                            throw new Exception("Пользователь с такой электронной почтой, уже зарегестрирован");
                        }
                        else
                        {
                        Email_add.Background = Brushes.White;
                        command.Parameters.AddWithValue("@Email", Email_add.Text);
                        }
                    }

                    if ((Password_add.Text == "" && rPassword_add.Text == "") )
                    {
                    Password_add.Background = Brushes.DarkRed;
                    throw new Exception ("Поле Пароль не должно быть пустым");
                       
                    }
                    else if (!Regex.IsMatch(Password_add.Text, "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^]).{6,}$"))
                    {
                    Password_add.Background = Brushes.DarkRed;
                    throw new Exception("Введите коректно пароль");
                    }
                    else if (this.Password_add.Text != rPassword_add.Text)
                    {
                    Password_add.Background = Brushes.DarkRed;
                    throw new Exception("Пароль не совпадает с указаным");
                    }

                    else
                    {
                    Password_add.Background = Brushes.White;
                    command.Parameters.AddWithValue("@Password", HashPassword.HashPass(Password_add.Text));

                    }
                    if (FirstName_add.Text == "" )
                    {
                    FirstName_add.Background = Brushes.DarkRed;
                    throw new Exception("Заполните поле Имя");
                       
                    }
                    
                    
                    else
                    {
                    FirstName_add.Background = Brushes.White;
                    command.Parameters.AddWithValue("@FirstName", FirstName_add.Text);
                    }
                    if (LastName_add.Text == "" )
                    {
                    LastName_add.Background = Brushes.DarkRed;
                    throw new Exception("Заполните поле Фамилия");
                       
                    }
                    else
                    {
                    LastName_add.Background = Brushes.White;
                    command.Parameters.AddWithValue("@LastName", LastName_add.Text);
                    }

                    if (Gender_add_ComboBox.Text == "" )
                    {
                    
                    throw new Exception("Выберете пол");
                       
                    }
                    else
                    {
                        if (Gender_add_ComboBox.Text == "Мужской")
                        {
                            command.Parameters.AddWithValue("@Gender", 1);
                        }
                        else
                        {
                            command.Parameters.AddWithValue("@Gender", 2);
                        }
                    }
                if (Birthday_add.Text == "")
                {
                    Birthday_add.Background = Brushes.DarkRed;
                    throw new Exception("Заполните поле даты рождения");
                }
                else
                {
                    if (IsValidAge(Birthday_add.Text, 10))
                    {
                        Birthday_add.Background = Brushes.White;
                        command.Parameters.AddWithValue("@DateOfBirth", Birthday_add.Text);
                    }
                    else
                    {
                        Birthday_add.Background = Brushes.DarkRed;
                        throw new Exception("Возраст не может быть меньше 10 лет");
                    }
                }

                if (Country_add_ComboBox.Text == "" )
                    {
                        throw new Exception("Выберете страну");
                       
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@CountryName", Country_add_ComboBox.Text.Trim());
                    }

                    int number = command.ExecuteNonQuery();
                    MessageBox.Show($"Учетная запись создана:{number - 1}");

                    MainWindow RegistrationUser = new MainWindow();
                    this.Close();
                    RegistrationUser.ShowDialog();
            }
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
            try
            {
                RegistrRunner();
            }
            catch (Exception ex)
            {
                Errorka.Text = ex.Message;
            }
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
