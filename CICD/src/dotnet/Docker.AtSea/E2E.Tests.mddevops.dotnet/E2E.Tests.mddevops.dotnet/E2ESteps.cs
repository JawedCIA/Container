using System;
using TechTalk.SpecFlow;
using NUnit.Framework;
using OpenQA.Selenium;
using SimpleBrowser.WebDriver;

namespace E2E.Tests.mddevops.dotnet
{
    [Binding]
    public class E2ESteps
    {
        private static IWebDriver _Driver;
        [BeforeFeature]
        public static void Setup()
        {
            _Driver = new SimpleBrowserDriver();
        }

        [AfterFeature]
        public static void TearDown()
        {
            _Driver.Close();
            _Driver.Dispose();
        }
        [Given(@"I navigate to the home page at ""(.*)""")]
        public void GivenINavigateToTheHomePageAt(string url)
        {
            _Driver.Navigate().GoToUrl(url);
        }
        
        [When(@"I see the home page")]
        public void WhenISeeTheHomePage()
        {
            Assert.NotNull(_Driver, "Unable to initialize WebDriver");
            Assert.AreEqual("Home Page V2", _Driver.Title.Trim());
        }
        
        [Then(@"the homepage should contain JS file ""(.*)""")]
        public void ThenTheHomepageShouldContainJSFile(string text)
        {
            var result = _Driver.FindElements(By.XPath("//*[@src='/Content/static/js/main.7416479b.js']"));
            Assert.IsNotNull(result, text);
        }
    }
}
