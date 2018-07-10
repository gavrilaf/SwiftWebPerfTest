from locust import HttpLocust, TaskSet, task


class UserBehavior(TaskSet):

    @task(1)
    def users(self):
        self.client.get("/1/users")

    @task(1)
    def roles(self):
        self.client.get("/1/roles/object-id")
    
    @task(1)
    def classes(self):
        self.client.get("/1/classes/class-name/object-id")



class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000