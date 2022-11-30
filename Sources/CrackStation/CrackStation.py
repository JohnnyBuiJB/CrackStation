import json
from aiohttp import web
import platform
import os
import json

class ShaHashCracker:
    def __init__(self, worlds=[]):
        __d_hash_path = './HashDict.json'
        system_name = platform.system()
        if system_name == "Darwin":     # Mac
            self.__log_path = \
                "/Users/johnnybui/repos/CrackStation/Sources/CrackStation/log/logs.txt"
                
        elif system_name == "Linux":    # EC2 instance
            import boto3    # EC2
            
            self.__log_path = "/home/ec2-user/logs.txt"
        
            # Download shahash table from S3
            if not os.path.exists(__d_hash_path):
                s3 = boto3.client('s3')
                s3.download_file('crack-station', 'HashDict.json', 'HashDict.json')
            
        with open(__d_hash_path) as f:
                self.__d_hash = json.load(f)

    async def decrypt(self, shaHash):
        try:
            password = self.__d_hash[shaHash]
        except:
            password = None
        
        return password

routes = web.RouteTableDef()

@routes.get("/password")
async def crack_shahash(request: web.Request) -> web.Response:
    # Sanity check
    if 'shaHash' not in request.query:
        response = web.json_response()
        response.set_status(400)
        
        return response
    
    shaHash = request.query['shaHash']
    
    print("shaHash = " + shaHash)
    
    password = await (request.app["cracker"]).decrypt(shaHash)
    
    if password:
        response = web.json_response({shaHash: password})
    else:
        response = web.json_response()
        response.set_status(404)
    
    return response

def init():
    app = web.Application()
    app.add_routes(routes)
    app["cracker"] = ShaHashCracker()
    
    system_name = platform.system()
    
    if system_name == "Darwin":     # Mac
        web.run_app(app, port="125")
    elif system_name == "Linux":    # EC2 instance
        web.run_app(app)
    
    
if __name__ == "__main__":
    init()
