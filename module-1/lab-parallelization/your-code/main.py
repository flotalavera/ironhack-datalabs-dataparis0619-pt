#!/usr/bin/env python
# coding: utf-8

# # Parallelization Lab
# 
# In this lab, you will be leveraging several concepts you have learned to obtain a list of links from a web page and crawl and index the pages referenced by those links - both sequentially and in parallel. Follow the steps below to complete the lab.

# ## Step 1: Use the requests library to retrieve the content from the URL below.

# In[ ]:


import requests

url = 'https://en.wikipedia.org/wiki/Data_science'


# In[ ]:


html = requests.get(url)


# ## Step 2: Use BeautifulSoup to extract a list of all the unique links on the page.

# In[ ]:


from bs4 import BeautifulSoup


# In[ ]:


soup = BeautifulSoup(html.text, 'lxml')
#print(soup)

links_html = soup.find_all('div', {'id': 'bodyContent' })

#links = [div.find_all('a') for div in links_html]

links = soup.find_all("a")[1:]
list_links = []
for elements in links:
   list_links.append(elements.get("href"))


#list_links = []
#for liste in links:
    #for a in liste:
        #if a.get('href'):
            #list_links.append(a.get('href'))

#a.get('href')
#a.get('title')



# ## Step 3: Use list comprehensions with conditions to clean the link list.
# 
# There are two types of links, absolute and relative. Absolute links have the full URL and begin with http while relative links begin with a forward slash (/) and point to an internal page within the wikipedia.org domain. Clean the respective types of URLs as follows.
# 
# - Absolute Links: Create a list of these and remove any that contain a percentage sign (%).
# - Relativel Links: Create a list of these, add the domain to the link so that you have the full URL, and remove any that contain a percentage sign (%).
# - Combine the list of absolute and relative links and ensure there are no duplicates.

# In[ ]:


domain = 'http://wikipedia.org'


# In[ ]:


absolute_links = [x for x in list_links if x.startswith('http') and '%' not in x]






# In[ ]:


relative_links = []
for x in list_links:
    if x.startswith('/') and '%' not in x:
        relative_links.append(domain + x)



# In[ ]:


clean_links_list = absolute_links + relative_links
clean_links = set(clean_links_list)



# ## Step 4: Use the os library to create a folder called *wikipedia* and make that the current working directory.

# In[ ]:


import os


# In[ ]:


os.chdir('/Users/floratalavera/ironhack/Labs/ironhack-datalabs-dataparis0619-pt/module-1/lab-parallelization')
#os.mkdir('Wikipedia')


# ## Step 5: Write a function called index_page that accepts a link and does the following.
# 
# - Tries to request the content of the page referenced by that link.
# - Slugifies the filename using the `slugify` function from the [python-slugify](https://pypi.org/project/python-slugify/) library and adds a .html file extension.
#     - If you don't already have the python-slugify library installed, you can pip install it as follows: `$ pip install python-slugify`.
#     - To import the slugify function, you would do the following: `from slugify import slugify`.
#     - You can then slugify a link as follows `slugify(link)`.
# - Creates a file in the wikipedia folder using the slugified filename and writes the contents of the page to the file.
# - If an exception occurs during the process above, just `pass`.

# In[ ]:


from slugify import slugify


# In[ ]:


def index_page(link):
    filename = slugify(link)
    #path = '/Users/floratalavera/ironhack/Labs/ironhack-datalabs-dataparis0619-pt/module-1/lab-parallelization/Wikipedia'
    f = open(filename, 'wb')
    response = requests.get(link).content
    f.write(response)


    
    
    


# In[ ]:


#os.chdir('Wikipedia')
#link = 'http://wikipedia.org/wiki/Recurrent_neural_network'
#filename = slugify(link)
#path = '/Users/floratalavera/ironhack/Labs/ironhack-datalabs-dataparis0619-pt/module-1/lab-parallelization/Wikipedia'
   
#f = open(filename, 'w+')
    
#response = requests.get(link).text
#f.write(response)
    
    


# In[ ]:





# ## Step 6: Sequentially loop through the list of links, running the index_page function each time.
# 
# Remember to include `%%time` at the beginning of the cell so that it measures the time it takes for the cell to run.

# In[ ]:





# ## Step 7: Perform the page indexing in parallel and note the difference in performance.
# 
# Remember to include `%%time` at the beginning of the cell so that it measures the time it takes for the cell to run.

# In[ ]:


import multiprocessing


# In[ ]:

if __name__ == "__main__":
    pool = multiprocessing.Pool()
    result = pool.map(index_page, clean_links)
    pool.terminate()
    pool.join()
    print(result)


# In[ ]:





# In[ ]:




