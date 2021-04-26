class TeleportService
  def self.conn
    Faraday.new(url: 'https://api.teleport.org')
  end

  def self.parse(response)
    JSON.parse(response.body)
  end 

  # def self.get_city_link(search)
  #   response = conn.get('/api/cities/') do |f|
  #     f.params['search'] = search
  #     f.params['limit'] = 1
  #   end
  #   return [] if parse(response)['_embedded']['city:search-results'].empty?
  #   parse(response)['_embedded']['city:search-results'][0]['_links']['city:item']['href']
  # end 

  # def self.get_urban_area_link(search)
  #   response = Faraday.get(get_city_link(search))
  #   parse(response)["_links"]["city:urban_area"]["href"]
  # end 
  
  # def self.get_salary_link(search)
  #   response = Faraday.get(get_urban_area_link(search))
  #   parse(response)['_links']['ua:salaries']['href']
  # end 

  def self.get_salary_link(search)
    response = conn.get("/api/urban_areas/slug%3A#{search}/")
    return [] if parse(response)['http_status_code']
    parse(response)['_links']['ua:salaries']['href']
  end 
  
  def self.get_salary_info(search)
    response = Faraday.get(get_salary_link(search))
    salaries = parse(response)['salaries']
    final_jobs = []
    jobs = ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Sofware Engineer', 'Systems Administrator', 'Web Developer']
    jobs.each do |job|
      salaries.map do |salary|
        if job == salary['job']['title']
          final_jobs << {
            title: salary['job']['title'],
            min: sprintf("$%2.2f", salary['salary_percentiles']['percentile_25']),
            max: sprintf("$%2.2f", salary['salary_percentiles']['percentile_75'])
          }
        end 
      end 
    end 
    final_jobs
  end 
end 