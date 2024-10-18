using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace _1C_app
{
    public class dateFormat
    {
        public static bool IsValidAge(string birthDateString, int minimumAge)
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
    }
}