Given /the password for the messages page is "(.*?)"$/ do |text|
  ENV["MESSAGES_PASSWORD"] = text
end

Given /^I am on the "(.*?)" page$/ do |page|
  visit "/#{page.downcase}.html"
end

Then /^a password prompt should be displayed$/ do
  page.should have_selector("input#password")
end

When /^I enter the text "(.*?)" in the "(.*?)" field$/ do |text, field_id|
  fill_in field_id, with: text
end

Then /^a table should contain the following rows of words$/ do |content|
  within("table") do
    content.each_line.each_with_index do |line, index|
      line.split(" ").each do |word|
        page.find(:xpath, ".//tr[#{index+1}]").should have_content(word)
      end
    end
  end
end

Then /^I should see the text "(.*?)"/ do |text|
  page.should have_content(text)
end

When /^I click the "(.*?)" button$/ do |button_id|
  click_on button_id
end

#And /^the Amazon S3 service is stubbed$/ do
  #mock_obj1 = mock
  #obj1_path = "/bucket1/2012.2.25 - Jaun Basan - Great Sermon.mp3"
  #mock_obj1.should_receive(:path).and_return(obj1_path)
  #mock_obj1.should_receive(:url).with(:epxires_in => (60*10)).and_return("http://test_url1")

  #mock_obj2 = mock
  #obj2_path = "/bucket1/2012.4.30 - Jaime Hernadez - Que?.mp3"
  #mock_obj1.should_receive(:path).and_return(obj2_path)
  #mock_obj1.should_receive(:url).with(:epxires_in => (60*10)).and_return("http://test_url2")

  #mock_bucket = mock
  #mock_bucket.should_receive(:objects).and_return([mock_obj1, mock_obj2])

  #AWS::S3::Bucket.should_receive(:find).
    #with("church_audio").and_return(mock_bucket)
#end

