Using this code base, you can run github actions pipe line which will perform the following actions.

1) It will scan all the repositories under the organization "https://github.com/venkat2286Org". Note: Please note that you can reconfigure the orgnaization in searchAPI.sh

2) It will generate the reports folder under which you can see two files:
  a) repos-with-api.txt: this file will list out all the repos with api end points.
  b) api-detailed-info.txt : this file will list out all the files in all repos with api end points.
  
  
  
  **What can be configured:**
  Note: Configuration files can be found in the/conf folder.
  
  **1) identifiers.txt**: We can configure api identifiers.
