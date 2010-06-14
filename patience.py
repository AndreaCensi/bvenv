import yaml, os, re, sys
import subprocess

def system_cmd(cmd):
    val = os.system(cmd)
    if val != 0:
        print "%s: %s" % (val, cmd)
    return val
        
    
def system_cmd_fail(cmd):
    res = os.system(cmd)
    if res != 0:
        raise Exception('Command "%s" failed. (ret vlaue: %s)' %(cmd, res))

def system_output(cmd):
    ''' Gets the output of a command. '''
    output = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()[0]
    return output
    
class Resource:
    def __init__(self, config):
        self.destination = config['destination']

    def is_downloaded(self):
        return os.path.exists(self.destination)

    def install(self):
        pass
        
    def __str__(self):
        return self.destination
        
    def checkout(self):    
        pass

    def update(self):
        pass

    def something_to_commit(self):
        return False

    def commit(self):
        pass

        
class Subversion(Resource):
    def __init__(self, config):
        Resource.__init__(self, config)
        self.url = config['url']
        
    def checkout(self):
        system_cmd_fail('svn checkout %s %s' % (self.url, self.destination))

    def update(self):
        system_cmd_fail('svn update %s' % (self.destination))

    def something_to_commit(self):
        return "" != system_output('svn status %s' % (self.destination))

    def commit(self):
        system_cmd_fail('svn commit %s' % (self.destination))

class Git(Resource):
    def __init__(self, config):
        Resource.__init__(self, config)
        self.url = config['url']
        self.branch = config.get('branch', 'master')

    def checkout(self):    
        system_cmd_fail('git clone %s %s' % (self.url, self.destination))

    def update(self):
        system_cmd_fail('git pull %s origin/%s' % (self.destination, self.branch))
        
    def something_to_commit(self):
        return 0 != system_cmd('cd %s && git diff --quiet --exit-code origin/%s' % (self.destination, self.branch))
        
    def commit(self):
        system_cmd_fail('git commit -a %s' % (self.destination))
        
    

def expand_environment(s):
    while True:
        m =  re.match('(.*)\$\{(\w+)\}(.*)', s)
        if not m:
            return s
        before = m.group(1)
        var = m.group(2)
        after = m.group(3)
        if not var in os.environ:
            raise ValueError('Could not find environment variable "%s".' % var)
        sub = os.environ[var]
        s = before+sub+after
        #print 'Expanded to %s' % s
            
def expand(r):
    ''' Expand environment variables found. '''
    for k in r.keys():
        r[k] = expand_environment(r[k])
    return r

def instantiate(config):
    res_type = config['type']
    if res_type == 'subversion':
        return Subversion(config)
    elif res_type == 'git':
        return Git(config)
    elif res_type == 'included':
        return Resource(config)
    else:
        raise Exception('Uknown resource type "%s".' % res_type)

if __name__=='__main__':
    config = 'resources.yaml'
    resources = list(yaml.load_all(open(config)))
    resources = map(expand, resources)
    resources = map(instantiate, resources)
    
    
    if len(sys.argv) < 2:
        raise Exception('Please provide command.')
    command = sys.argv[1]
    

    if command == 'checkout':
        for r in resources:
            if not r.is_downloaded():
                print 'Downloading %s...' % r
                r.checkout()
            else:
                print 'Already downloaded %s.' % r 
                
    elif command == 'update':
        for r in resources:
            r.update()

    elif command == 'install':
        for r in resources:
            r.install()

    elif command == 'status':
        for r in resources:
            if not r.is_downloaded():
                raise Exception('Could not verify status of "%s" before download.' % r)
            
            if r.something_to_commit():
                print "%s: something to commit." % r
            else:
                pass
#                print "%s: all ok." % r
           
    elif command == 'commit':
        for r in resources:
            r.commit()
    else:
        raise Exception('Uknown command "%s".' % command)
        
        