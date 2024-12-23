﻿using System;
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
       //string connectionString = "Server=.\\SQLEXPRESS;Database=DSA;Trusted_Connection=True;";
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

                    
                    string sqlQuery = $"SELECT u.Password, r.RoleName FROM [User] u INNER JOIN [Role] r ON u.RoleId = r.RoleId WHERE u.Email = '{Global.Login}'";

                    using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                    {
                        string hashedEnteredPassword = HashPassword.HashPass(enteredPassword);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string hashedPasswordFromDB = reader["Password"].ToString();
                                string roleName = reader["RoleName"].ToString();

                                
                                if (hashedPasswordFromDB.Equals(hashedEnteredPassword))
                                {
                                    
                                    if (roleName == "Бегун")
                                    {
                                        ChoiceUser LoginApp = new ChoiceUser();
                                        this.Close();
                                        LoginApp.ShowDialog();
                                    }
                                    else if (roleName == "Администратор")
                                    {
                                        MenuAdministratora LoginApp = new MenuAdministratora();
                                        this.Close();
                                        LoginApp.ShowDialog();
                                    }
                                    else if (roleName == "Координатор")
                                    {
                                        MenuKoordinatora LoginApp = new MenuKoordinatora();
                                        this.Close();
                                        LoginApp.ShowDialog();
                                    }
                                    else
                                    {
                                        MessageBox.Show("Неизвестная роль");
                                    }
                                }
                                else
                                {
                                    MessageBox.Show("Неверная электронная почта или пароль");
                                }
                            }
                            else
                            {
                                MessageBox.Show("Неверная электронная почта или пароль");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}");
                }
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

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
