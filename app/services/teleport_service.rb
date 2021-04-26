class TeleportService
  def self.conn
    Faraday.new(url: 'https://api.teleport.org')
  end

  def self.parse(response)
    JSON.parse(response.body)
  end 

  def self.get_salary_link(destination)
    response = conn.get("/api/urban_areas/slug%3A#{destination}/")

    return [] if response.status != 200
    parse(response)['_links']['ua:salaries']['href']
  end 
  
  def self.get_salary_info(destination)
    response = Faraday.get(get_salary_link(destination))
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