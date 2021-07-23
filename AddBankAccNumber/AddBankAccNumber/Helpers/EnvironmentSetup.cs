using AddBankAccNumber.Properties;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.Helpers
{
    public class EnvironmentSetup
    {
        /// <summary>
        /// The <c>GetEnvironmentVariables</c> method returns a string <returns>variableValue</returns>.
        /// Sets the default value as declared in the Resources Properties file,
        /// else the Environment Variable value is used.
        /// </summary>
        public string GetEnvironmentVariables(string envVar)
        {
            string variableValue = Environment.GetEnvironmentVariable(envVar);
            string defaultvariableValue = Resources.ResourceManager.GetString(envVar);
            if (string.IsNullOrEmpty(variableValue))
            {
                variableValue = defaultvariableValue;
            }

            return variableValue;
        }
    }
}
